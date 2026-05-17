#include "ros/ros.h"
#include <geometry_msgs/Twist.h>
#include <nav_msgs/Odometry.h>
#include <sensor_msgs/LaserScan.h>
#include <std_msgs/String.h>
#include "delivery_system/TaskReport.h"
#include "delivery_system/ExceptionHandle.h"
#include <tf/tf.h>
#include <vector>
#include <string>
#include <cmath>
#include <math.h>
#include <mutex>
#include <locale>
#include <utility>

class DeliveryRobot
{
public:
    enum NavMode { Direct, AutoAvoid, ManualPath };

    DeliveryRobot()
        : nh_("~"),
          current_x_(0),
          current_y_(0),
          current_yaw_(0),
          obstacle_detected_(false),
          avoid_turn_sign_(1.0),
          avoid_clear_frames_(0),
          nav_mode_(Direct)
    {
        vel_pub_ = nh_.advertise<geometry_msgs::Twist>("/cmd_vel", 10);
        status_pub_ = nh_.advertise<std_msgs::String>("/delivery_status", 10);
        odom_sub_ = nh_.subscribe("/odom", 10, &DeliveryRobot::odomCallback, this);
        laser_sub_ = nh_.subscribe("/scan", 10, &DeliveryRobot::laserCallback, this);

        ROS_INFO("正在从参数服务器加载配送任务配置...");
        nh_.getParam("/delivery_timeout", delivery_timeout_);
        ROS_INFO("配送超时时间：%.1f 秒", delivery_timeout_);

        std::vector<std::string> station_names = {"station_1", "station_2", "station_3"};
        for (auto& name : station_names)
        {
            double x, y, theta;
            nh_.getParam("/stations/" + name + "/x", x);
            nh_.getParam("/stations/" + name + "/y", y);
            nh_.getParam("/stations/" + name + "/theta", theta);
            station_list_.push_back({name, x, y, theta});
            ROS_INFO("加载站点：%s，坐标(%.1f, %.1f)", name.c_str(), x, y);
        }

        report_client_ = nh_.serviceClient<delivery_system::TaskReport>("/task_report");
        exception_client_ = nh_.serviceClient<delivery_system::ExceptionHandle>("/exception_handle");

        start_time_ = ros::Time::now();
        ROS_INFO("配送机器人初始化完成，等待启动...");
    }

    void odomCallback(const nav_msgs::Odometry::ConstPtr& msg)
    {
        std::lock_guard<std::mutex> lock(odom_mutex_);
        current_x_ = msg->pose.pose.position.x;
        current_y_ = msg->pose.pose.position.y;
        tf::Quaternion q(
            msg->pose.pose.orientation.x,
            msg->pose.pose.orientation.y,
            msg->pose.pose.orientation.z,
            msg->pose.pose.orientation.w);
        tf::Matrix3x3 m(q);
        double roll, pitch;
        m.getRPY(roll, pitch, current_yaw_);
    }

    static bool validRange(const sensor_msgs::LaserScan::ConstPtr& msg, float r)
    {
        return std::isfinite(static_cast<double>(r)) && r > msg->range_min && r < msg->range_max;
    }

    void laserCallback(const sensor_msgs::LaserScan::ConstPtr& msg)
    {
        const int n = static_cast<int>(msg->ranges.size());
        if (n <= 0)
        {
            obstacle_detected_ = false;
            return;
        }

        const int front_center = n / 2;
        const int narrow_half = 15;
        obstacle_detected_ = false;

        for (int i = front_center - narrow_half; i < front_center + narrow_half; ++i)
        {
            if (i >= 0 && i < n)
            {
                const float r = msg->ranges[i];
                if (validRange(msg, r) && r < 0.5f)
                {
                    obstacle_detected_ = true;
                    break;
                }
            }
        }

        if (!obstacle_detected_)
            return;

        const int wide_outer = 55;
        auto sectorMean = [&](int lo, int hi) -> double
        {
            double sum = 0.0;
            int cnt = 0;
            for (int i = lo; i < hi && i < n; ++i)
            {
                if (i < 0)
                    continue;
                const float r = msg->ranges[i];
                if (validRange(msg, r))
                {
                    sum += static_cast<double>(r);
                    ++cnt;
                }
            }
            return cnt > 0 ? sum / static_cast<double>(cnt) : 0.0;
        };

        const double left_mean = sectorMean(front_center + narrow_half, front_center + wide_outer);
        const double right_mean = sectorMean(front_center - wide_outer, front_center - narrow_half);

        if (left_mean >= right_mean)
            avoid_turn_sign_ = 1.0;
        else
            avoid_turn_sign_ = -1.0;
    }

    void publishStop()
    {
        geometry_msgs::Twist stop_vel;
        stop_vel.linear.x = 0;
        stop_vel.angular.z = 0;
        for (int i = 0; i < 3; ++i)
        {
            vel_pub_.publish(stop_vel);
            ros::Duration(0.1).sleep();
        }
    }

    bool callExceptionService(delivery_system::ExceptionHandle& srv)
    {
        while (ros::ok())
        {
            if (exception_client_.call(srv))
            {
                if (srv.response.confirm_continue)
                    return true;
            }
            else
            {
                ROS_WARN("等待人工处理服务，1秒后重试...");
                ros::Duration(1.0).sleep();
            }
        }
        return false;
    }

    void appendGoalIfNeeded(double goal_x, double goal_y)
    {
        if (manual_waypoints_.empty())
        {
            manual_waypoints_.push_back({goal_x, goal_y});
            return;
        }

        const auto& last = manual_waypoints_.back();
        const double dx = goal_x - last.first;
        const double dy = goal_y - last.second;
        if (sqrt(dx * dx + dy * dy) > 0.2)
            manual_waypoints_.push_back({goal_x, goal_y});
    }

    // 遇障：停车上报人工，确认后自主绕行或按人工路径通行（无需删除障碍）
    bool handleObstacleEvent(const std::string& station_name, double goal_x, double goal_y)
    {
        publishStop();

        const std::string error =
            "前往" + station_name + "时前方发现障碍物，已停车等待人工指定通行方式";
        exception_records_.push_back(error);

        std_msgs::String status_msg;
        status_msg.data = "障碍上报：" + error;
        status_pub_.publish(status_msg);

        ROS_ERROR("========================================");
        ROS_ERROR("【障碍上报】%s", error.c_str());
        ROS_ERROR("机器人位置：(%.2f, %.2f)", current_x_, current_y_);
        ROS_ERROR("目标站点：%s (%.2f, %.2f)", station_name.c_str(), goal_x, goal_y);
        ROS_ERROR("请在人工处理终端选择：");
        ROS_ERROR("  a → 自主绕行（障碍保留不删除）");
        ROS_ERROR("  p x1 y1 x2 y2 ... → 下发绕行途经点");
        ROS_ERROR("========================================");

        delivery_system::ExceptionHandle srv;
        srv.request.error_message = error;
        srv.request.is_obstacle = true;
        srv.request.station_name = station_name;
        srv.request.goal_x = goal_x;
        srv.request.goal_y = goal_y;
        srv.request.robot_x = current_x_;
        srv.request.robot_y = current_y_;

        if (!callExceptionService(srv))
            return false;

        if (srv.response.action_mode == 1)
        {
            nav_mode_ = AutoAvoid;
            avoid_clear_frames_ = 0;
            ROS_INFO("人工已确认【自主绕行】，机器人开始尝试绕过障碍");
            status_msg.data = "障碍处理：自主绕行中";
            status_pub_.publish(status_msg);
            return true;
        }

        if (srv.response.action_mode == 2)
        {
            if (srv.response.path_x.size() != srv.response.path_y.size() ||
                srv.response.path_x.empty())
            {
                ROS_ERROR("人工路径数据无效，请重新上报");
                return false;
            }

            manual_waypoints_.clear();
            manual_wp_index_ = 0;
            for (size_t i = 0; i < srv.response.path_x.size(); ++i)
                manual_waypoints_.push_back({srv.response.path_x[i], srv.response.path_y[i]});
            appendGoalIfNeeded(goal_x, goal_y);

            nav_mode_ = ManualPath;
            ROS_INFO("人工已下发绕行路径，共 %zu 个目标点", manual_waypoints_.size());
            status_msg.data = "障碍处理：按人工路径通行";
            status_pub_.publish(status_msg);
            return true;
        }

        ROS_WARN("未收到有效通行指令，保持停车");
        return false;
    }

    bool reportException(const std::string& error_msg)
    {
        publishStop();

        exception_records_.push_back(error_msg);
        std_msgs::String status_msg;
        status_msg.data = "异常：" + error_msg;
        status_pub_.publish(status_msg);

        ROS_ERROR("========================================");
        ROS_ERROR("【异常上报】%s", error_msg.c_str());
        ROS_ERROR("请在终端输入小写 c 并按回车确认继续");
        ROS_ERROR("========================================");

        delivery_system::ExceptionHandle srv;
        srv.request.error_message = error_msg;
        srv.request.is_obstacle = false;

        if (!callExceptionService(srv))
            return false;

        ROS_INFO("收到人工确认，机器人继续运行");
        obstacle_detected_ = false;
        ros::Duration(1.0).sleep();
        return true;
    }

    std::pair<double, double> currentTarget(double goal_x, double goal_y) const
    {
        if (nav_mode_ == ManualPath && manual_wp_index_ < manual_waypoints_.size())
            return manual_waypoints_[manual_wp_index_];
        return {goal_x, goal_y};
    }

    double distanceTo(double tx, double ty) const
    {
        const double dx = tx - current_x_;
        const double dy = ty - current_y_;
        return sqrt(dx * dx + dy * dy);
    }

    void driveToward(double tx, double ty, geometry_msgs::Twist& vel_msg)
    {
        const double target_angle = atan2(ty - current_y_, tx - current_x_);
        double angle_error = target_angle - current_yaw_;
        while (angle_error > M_PI) angle_error -= 2 * M_PI;//归一化到[-\pi, \pi]
        while (angle_error < -M_PI) angle_error += 2 * M_PI;//归一化到[]-\pi, \pi

        const double distance = distanceTo(tx, ty);
        vel_msg.angular.z = 1.0 * angle_error;
        if (fabs(angle_error) < 0.3)
        {
            vel_msg.linear.x = 0.5 * distance;
            if (vel_msg.linear.x > 0.5)
                vel_msg.linear.x = 0.5;
        }
        else
        {
            vel_msg.linear.x = 0;
        }
    }

    bool goToStation(const std::string& station_name, double goal_x, double goal_y)
    {
        ROS_INFO("开始前往【%s】", station_name.c_str());
        nav_mode_ = Direct;
        manual_waypoints_.clear();
        manual_wp_index_ = 0;

        std_msgs::String status_msg;
        status_msg.data = "前往站点：" + station_name;
        status_pub_.publish(status_msg);

        ros::Rate rate(10);
        geometry_msgs::Twist vel_msg;
        ros::Time station_start_time = ros::Time::now();

        while (ros::ok())
        {
            const auto target = currentTarget(goal_x, goal_y);
            const double tx = target.first;
            const double ty = target.second;
            const double distance = distanceTo(tx, ty);

            // 自主绕行：前方有障则转向，前方通畅则慢速朝目标推进；连续多帧前方通畅才退出绕行
            if (nav_mode_ == AutoAvoid)
            {
                if (obstacle_detected_)
                {
                    avoid_clear_frames_ = 0;
                    ROS_WARN_THROTTLE(2.0, "自主绕行中：前方有障，原地转向...");
                    vel_msg.linear.x = 0.0;
                    vel_msg.angular.z = avoid_turn_sign_ * 0.75;
                }
                else
                {
                    ++avoid_clear_frames_;
                    if (avoid_clear_frames_ < 15)
                    {
                        // 刚转开障碍：沿切向慢速前进，避免立刻再次对准障碍
                        vel_msg.linear.x = 0.2;
                        vel_msg.angular.z = avoid_turn_sign_ * 0.4;
                    }
                    else
                    {
                        driveToward(tx, ty, vel_msg);
                        if (vel_msg.linear.x > 0.25)
                            vel_msg.linear.x = 0.25;
                    }
                    if (avoid_clear_frames_ >= 40)
                    {
                        nav_mode_ = Direct;
                        avoid_clear_frames_ = 0;
                        ROS_INFO("绕行阶段结束，恢复全速前往站点【%s】", station_name.c_str());
                        status_msg.data = "绕行完成，继续前往：" + station_name;
                        status_pub_.publish(status_msg);
                    }
                }
                vel_pub_.publish(vel_msg);
                ros::spinOnce();
                rate.sleep();
                continue;
            }

            if (obstacle_detected_)
            {
                if (!handleObstacleEvent(station_name, goal_x, goal_y))
                    return false;

                ros::spinOnce();
                rate.sleep();
                continue;
            }

            double used_time = (ros::Time::now() - station_start_time).toSec();
            if (used_time > delivery_timeout_)
            {
                std::string error =
                    "前往" + station_name + "超时，超时时间" + std::to_string((int)delivery_timeout_) + "秒";
                if (!reportException(error))
                    return false;
                station_start_time = ros::Time::now();
                ROS_INFO("超时已确认，继续尝试前往【%s】", station_name.c_str());
                continue;
            }

            if (nav_mode_ == ManualPath && distance < 0.2)
            {
                ROS_INFO("到达人工路径点 %zu / %zu", manual_wp_index_ + 1, manual_waypoints_.size());
                ++manual_wp_index_;
                if (manual_wp_index_ >= manual_waypoints_.size())
                {
                    nav_mode_ = Direct;
                    ROS_INFO("人工路径执行完毕，继续前往站点【%s】", station_name.c_str());
                }
                ros::spinOnce();
                rate.sleep();
                continue;
            }

            if (nav_mode_ == Direct && distanceTo(goal_x, goal_y) < 0.2)
            {
                vel_msg.linear.x = 0;
                vel_msg.angular.z = 0;
                vel_pub_.publish(vel_msg);

                ROS_INFO("成功到达【%s】！", station_name.c_str());
                status_msg.data = "到达站点：" + station_name;
                status_pub_.publish(status_msg);
                arrived_stations_.push_back(station_name);
                ros::Duration(1.0).sleep();
                return true;
            }

            driveToward(tx, ty, vel_msg);
            vel_pub_.publish(vel_msg);
            ros::spinOnce();
            rate.sleep();
        }
        return false;
    }

    void run()
    {
        ros::Duration(3.0).sleep();
        start_time_ = ros::Time::now();
        ROS_INFO("配送任务正式开始！");

        for (auto& station : station_list_)
        {
            if (!ros::ok())
                break;
            goToStation(station.name, station.x, station.y);
        }

        end_time_ = ros::Time::now();
        generateTaskReport();

        std_msgs::String status_msg;
        status_msg.data = "配送任务全部完成！";
        status_pub_.publish(status_msg);
        ROS_INFO("所有配送任务执行完毕！");
    }

    void generateTaskReport()
    {
        delivery_system::TaskReport srv;
        srv.request.total_time = (end_time_ - start_time_).toSec();
        srv.request.arrived_stations = arrived_stations_;
        srv.request.exceptions = exception_records_;

        if (report_client_.call(srv))
            ROS_INFO("任务报告生成成功：%s", srv.response.message.c_str());
        else
            ROS_ERROR("任务报告服务调用失败！");
    }

private:
    ros::NodeHandle nh_;
    ros::Publisher vel_pub_;
    ros::Publisher status_pub_;
    ros::Subscriber odom_sub_;
    ros::Subscriber laser_sub_;
    ros::ServiceClient report_client_;
    ros::ServiceClient exception_client_;

    std::mutex odom_mutex_;
    double current_x_, current_y_, current_yaw_;
    bool obstacle_detected_;
    double avoid_turn_sign_;
    int avoid_clear_frames_;
    double delivery_timeout_;

    NavMode nav_mode_;
    std::vector<std::pair<double, double>> manual_waypoints_;
    size_t manual_wp_index_ = 0;

    struct Station
    {
        std::string name;
        double x, y, theta;
    };
    std::vector<Station> station_list_;
    std::vector<std::string> arrived_stations_;
    std::vector<std::string> exception_records_;
    ros::Time start_time_, end_time_;
};

int main(int argc, char** argv)
{
    setlocale(LC_ALL, "");
    ros::init(argc, argv, "delivery_core");

    DeliveryRobot robot;
    robot.run();
    return 0;
}
