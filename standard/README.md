# ROS (kinetic) on docker

## 検証環境

- OS: Ubuntu MATE 16.04.3
- docker: 18.09.0

## ビルド手順

```bash
# Dockerfileが配置されたディレクトリに移動
$ cd /path/to/ros-kinetic-on-docker/standard
# docker buildを実行
$ docker build --tag ros:kinetic-desktop-standard
```

## 動作確認

```bash
# ネットワークの作成
docker network create rosnet
```

```bash
# roscoreのコンテナを起動
$ cd /path/to/ros-kinetic-on-docker/standard
$ ./run.bash --name roscore --net rosnet
Usage:
./run.bash [OPTIONS]

OPTIONS: --name ros_test

$ roscore

SUMMARY
========

PARAMETERS
 * /rosdistro: kinetic
 * /rosversion: 1.12.14

NODES

auto-starting new master
process[master]: started with pid [55]
ROS_MASTER_URI=http://6f6412fba6a4:11311/

setting /run_id to e232273a-e64f-11e8-a431-0242ac120002
process[rosout-1]: started with pid [68]
started core service [/rosout]
```

```bash
# rvizのコンテナを起動
$ cd /path/to/ros-kinetic-on-docker/standard
$ ./run.bash --name rviz --net rosnet --env ROS_HOSTNAME=rviz --env ROS_MASTER_URI=http://6f6412fba6a4:11311/
Usage:
./run.bash [OPTIONS]

OPTIONS: --name rviz --net rosnet --env ROS_HOSTNAME=rviz --env ROS_MASTER_URI=http://6f6412fba6a4:11311/

$ rosrun rviz rviz
[ INFO] [1542009344.854182363]: rviz version 1.12.16
[ INFO] [1542009344.854230633]: compiled against Qt version 5.5.1
[ INFO] [1542009344.854240831]: compiled against OGRE version 1.9.0 (Ghadamon)
[ INFO] [1542009345.366723839]: Stereo is NOT SUPPORTED
[ INFO] [1542009345.366854568]: OpenGl version: 4.5 (GLSL 4.5).
```

rvizが立ち上がればOK．
