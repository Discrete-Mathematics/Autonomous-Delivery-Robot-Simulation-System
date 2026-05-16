cmake_minimum_required(VERSION 3.0.2)
project(delivery_system)

## 编译配置
add_compile_options(-std=c++11)

## 查找ROS依赖包
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  geometry_msgs
  nav_msgs
  sensor_msgs
  tf
  message_generation
  message_runtime
)

## 生成服务文件
add_service_files(
  FILES
  TaskReport.srv
  ExceptionHandle.srv
)

## 生成消息头文件
generate_messages(
  DEPENDENCIES
  std_msgs
)

## catkin配置
catkin_package(
  CATKIN_DEPENDS roscpp std_msgs geometry_msgs nav_msgs sensor_msgs tf message_runtime
)

## 头文件路径
include_directories(
  ${catkin_INCLUDE_DIRS}
)

###########
## 编译 ##
###########

# 1. 编译任务报告服务节点
add_executable(report_server src/report_server.cpp)
add_dependencies(report_server ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(report_server ${catkin_LIBRARIES})

# 2. 编译人工异常处理节点
add_executable(human_operator src/human_operator.cpp)
add_dependencies(human_operator ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(human_operator ${catkin_LIBRARIES})

# 3. 编译配送核心节点
add_executable(delivery_core src/delivery_core.cpp)
add_dependencies(delivery_core ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(delivery_core ${catkin_LIBRARIES})
