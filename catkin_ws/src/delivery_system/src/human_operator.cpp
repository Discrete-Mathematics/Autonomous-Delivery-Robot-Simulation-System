#include "ros/ros.h"
#include "delivery_system/ExceptionHandle.h"
#include <iostream>
#include <sstream>
#include <locale>
#include <vector>

static bool parseManualPath(const std::string& input,
                            std::vector<double>& path_x,
                            std::vector<double>& path_y)
{
  std::string data = input;
  if (data.size() >= 1 && data[0] == 'p')
    data = data.substr(1);
  else if (data.size() >= 4 && data.substr(0, 4) == "path")
    data = data.substr(4);

  std::istringstream iss(data);
  double x = 0.0, y = 0.0;
  path_x.clear();
  path_y.clear();
  while (iss >> x >> y)
  {
    path_x.push_back(x);
    path_y.push_back(y);
  }
  return !path_x.empty();
}

bool handleException(delivery_system::ExceptionHandle::Request& req,
                     delivery_system::ExceptionHandle::Response& res)
{
  res.confirm_continue = false;
  res.action_mode = 0;
  res.path_x.clear();
  res.path_y.clear();

  if (req.is_obstacle)
  {
    ROS_WARN("==================== 障碍物上报 ====================");
    ROS_WARN("目标站点：%s (%.2f, %.2f)", req.station_name.c_str(), req.goal_x, req.goal_y);
    ROS_WARN("机器人位置：(%.2f, %.2f)", req.robot_x, req.robot_y);
    ROS_WARN("说明：%s", req.error_message.c_str());
    ROS_INFO("障碍物无需删除，请选择通行方式：");
    ROS_INFO("  输入 a  → 确认后由机器人自主绕行");
    ROS_INFO("  输入 p x1 y1 x2 y2 ...  → 指定绕行途经点（将自动前往目标站点）");
    ROS_INFO("示例：p 1.0 2.0 1.5 3.0");
    ROS_INFO("====================================================");

    std::string input;
    while (ros::ok())
    {
      std::getline(std::cin, input);
      if (input == "a" || input == "A" || input == "auto")
      {
        res.confirm_continue = true;
        res.action_mode = 1;
        ROS_INFO("已选择【自主绕行】，机器人将尝试绕过障碍继续前往站点");
        return true;
      }

      if (!input.empty() && (input[0] == 'p' || input.substr(0, 4) == "path"))
      {
        std::vector<double> px, py;
        if (parseManualPath(input, px, py))
        {
          res.confirm_continue = true;
          res.action_mode = 2;
          res.path_x = px;
          res.path_y = py;
          ROS_INFO("已下发人工路径，共 %zu 个途经点", px.size());
          for (size_t i = 0; i < px.size(); ++i)
            ROS_INFO("  途经点 %zu: (%.2f, %.2f)", i + 1, px[i], py[i]);
          return true;
        }
        ROS_INFO("路径格式错误，请使用：p x1 y1 x2 y2 ...");
        continue;
      }

      ROS_INFO("无效输入。请输入 a（自主绕行）或 p x1 y1 x2 y2 ...（人工路径）");
    }
    return false;
  }

  ROS_WARN("==================== 异常上报 ====================");
  ROS_WARN("机器人异常：%s", req.error_message.c_str());
  ROS_INFO("请处理异常后，在终端输入 c 并回车，确认机器人继续执行任务");
  ROS_INFO("===================================================");

  std::string input;
  while (ros::ok())
  {
    std::getline(std::cin, input);
    if (input == "c" || input == "C")
    {
      res.confirm_continue = true;
      res.action_mode = 0;
      ROS_INFO("已发送继续指令，机器人将恢复运行");
      return true;
    }
    ROS_INFO("输入无效，请输入 c 并回车确认继续");
  }
  return false;
}

int main(int argc, char** argv)
{
  setlocale(LC_ALL, "");
  ros::init(argc, argv, "human_operator");
  ros::NodeHandle nh;

  ros::ServiceServer exception_service =
      nh.advertiseService("exception_handle", handleException);
  ROS_INFO("人工异常处理节点已启动，等待机器人上报...");

  ros::MultiThreadedSpinner spinner(2);
  spinner.spin();
  return 0;
}
