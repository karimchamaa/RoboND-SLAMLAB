#!/bin/bash

# Build the catkin_ws
cd $(pwd)/../../../
catkin_make

# Launch the nodes 
xterm  -e "source devel/setup.bash ; roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=worlds/willowgarage.world " &
sleep 5
xterm  -e "source devel/setup.bash ; roslaunch turtlebot_teleop keyboard_teleop.launch " &
sleep 2
xterm -e "source devel/setup.bash ; rosrun gmapping slam_gmapping  " &
sleep 3
xterm  -e "source devel/setup.bash ; rosrun rviz rviz -d $(pwd)/src/RoboND-SLAMLAB/config/slam.rviz" &

# Termiante the project
echo "Press Enter key to terminate the project"
read -s -n 1 key
if [[ $key = "" ]]; then 
	killall -e xterm
	echo "Project terminated!"
fi
