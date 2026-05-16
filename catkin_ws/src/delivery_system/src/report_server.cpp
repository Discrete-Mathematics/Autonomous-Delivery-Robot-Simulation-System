#include "ros/ros.h"
#include "delivery_system/TaskReport.h"
#include <fstream>
#include <locale>

// 服务回调函数：处理任务报告请求
bool handleTaskReport(delivery_system::TaskReport::Request  &req,
                      delivery_system::TaskReport::Response &res)
{
  // 打印报告到终端
  ROS_INFO("==================== 配送任务报告 ====================");
  ROS_INFO("总耗时：%.2f 秒", req.total_time);
  
  ROS_INFO("成功到达站点：");
  for (size_t i = 0; i < req.arrived_stations.size(); ++i) {
    ROS_INFO("  - %s", req.arrived_stations[i].c_str());
  }

  ROS_INFO("异常记录：");
  if(req.exceptions.empty()){
    ROS_INFO("  - 无异常");
  }else{
    for (size_t i = 0; i < req.exceptions.size(); ++i) {
      ROS_INFO("  - %s", req.exceptions[i].c_str());
    }
  }
  ROS_INFO("======================================================");

  // 把报告保存到本地文件
  std::ofstream report_file;
  report_file.open("/home/ubuntu/delivery_report.txt"); // 保存到主目录，方便查看
  report_file << "==================== 配送任务报告 ====================" << std::endl;
  report_file << "总耗时：" << req.total_time << " 秒" << std::endl;
  report_file << "成功到达站点：" << std::endl;
  for (auto &station : req.arrived_stations) report_file << "  - " << station << std::endl;
  report_file << "异常记录：" << std::endl;
  if(req.exceptions.empty()){
    report_file << "  - 无异常" << std::endl;
  }else{
    for (auto &error : req.exceptions) report_file << "  - " << error << std::endl;
  }
  report_file << "======================================================" << std::endl;
  report_file.close();

  // 返回响应
  res.success = true;
  res.message = "报告已生成，保存路径：/home/ubuntu/delivery_report.txt";
  return true;
}

int main(int argc, char **argv)
{
  // 解决中文乱码
  setlocale(LC_ALL, "");
  // 初始化ROS节点
  ros::init(argc, argv, "report_server");
  ros::NodeHandle nh;

  // 创建服务
  ros::ServiceServer report_service = nh.advertiseService("task_report", handleTaskReport);
  ROS_INFO("任务报告服务已启动，等待任务完成...");
  
  // 保持节点运行
  ros::spin();
  return 0;
}
