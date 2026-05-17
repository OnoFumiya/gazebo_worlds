#!/bin/bash
echo "╔══╣ Setup: Gazebo Worlds (STARTING) ╠══╗"

sudo apt update
sudo apt install ros-$ROS_DISTRO-xacro

DIR=$(pwd)
cd ..

ros_packages=(
    "tmc_wrs_gz" \
    "aws_small_house_world"
)

# Clone all packages
for ((i = 0; i < ${#ros_packages[@]}; i++)) {
    echo "Clonning: ${ros_packages[i]}"
    git clone -b jazzy-devel https://github.com/TeamSOBITS/${ros_packages[i]}.git
}

cd tmc_wrs_gz/tmc_wrs_gz
sed -i "s/cmake_minimum_required(VERSION 3.8)/cmake_minimum_required(VERSION 3.10)/" CMakeLists.txt

cd ../tmc_wrs_gz_launch
sed -i "s/cmake_minimum_required(VERSION 3.8)/cmake_minimum_required(VERSION 3.10)/" CMakeLists.txt

cd ../../aws_small_house_world
sed -i "s/cmake_minimum_required(VERSION 3.8)/cmake_minimum_required(VERSION 3.10)/" CMakeLists.txt

cd ${DIR}

# echo "export GZ_SIM_RESOURCE_PATH=${HOME}/colcon_ws/install/sobits_gazebo_worlds/share/sobits_gazebo_worlds/models" >> ~/.bashrc

mkdir -p ~/.gz/sim/10/
sudo cp -r config/gui.config ${HOME}/.gz/sim/10/

echo "export GZ_SIM_RESOURCE_PATH=~/colcon_ws/install/gazebo_worlds/share/gazebo_worlds/models" >> ~/.bashrc
export "GZ_SIM_RESOURCE_PATH=~/colcon_ws/install/gazebo_worlds/share/gazebo_worlds/models"

echo "export GZ_SIM_RESOURCE_PATH=${GZ_SIM_RESOURCE_PATH}:~/colcon_ws/install/tmc_wrs_gz_worlds/share/tmc_wrs_gz_worlds/models" >> ~/.bashrc
export "GZ_SIM_RESOURCE_PATH="${GZ_SIM_RESOURCE_PATH}":~/colcon_ws/install/tmc_wrs_gz_worlds/share/tmc_wrs_gz_worlds/models"

echo "export GZ_SIM_RESOURCE_PATH=${GZ_SIM_RESOURCE_PATH}:~/colcon_ws/install/aws_small_house_world/share/aws_small_house_world/models" >> ~/.bashrc
export "GZ_SIM_RESOURCE_PATH="${GZ_SIM_RESOURCE_PATH}":~/colcon_ws/install/aws_small_house_world/share/aws_small_house_world/models"

source ~/.bashrc

echo "╚══╣ Setup: Gazebo Worlds (FINISHED) ╠══╝"
