# ROS on docker

[![Docker Build Status](https://img.shields.io/docker/cloud/build/shinsumicco/ros.svg)](https://hub.docker.com/r/shinsumicco/ros)

## Overview

ROSをdocker上で動かすサンプル．  
rvizなどのOpenGLを使うGUIアプリケーションも多分動くはず．

参考資料:  
[Installing and Configuring Your ROS Environment](http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment)  
[Using Hardware Acceleration with Docker](http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration)

## 検証環境

- OS: Ubuntu MATE 16.04.1
- docker: 18.09.0

NVIDIAのグラフィックスドライバを使う場合については以下で検証済み．

- NVIDIA driver: 384.111
- nvidia-docker: 2.0.3 (**1系のnvidia-dockerでは未検証**)

以降では，**ROSのバージョン**と**グラフィックスドライバの種類**は環境に応じて**適宜変更**する．

現状では，ROSのバージョンは`kinetic`のみに対応している．  
Linux標準のグラフィックスドライバを使っている場合は`standard`，NVIDIAのグラフィックスドライバを使っている場合は`nvidia`とする．

## イメージのビルド (省略可)

環境とROSのバージョンに応じてイメージ名と使用する`Dockerfile`を変更する．  
以下は，`kinetic`をLinux標準のグラフィックスドライバ環境(`standard`)で使う場合のコマンドである．

```bash
$ cd /path/to/docker-ros/
$ docker build --tag shinsumicco/ros:kinetic-desktop-standard --file Dockerfile.kinetic.standard .
```

[DockerHubのビルド済みイメージ](https://hub.docker.com/r/shinsumicco/ros)を使う場合は，以下のコマンドで`pull`する．

```bash
$ docker pull shinsumicco/ros:kinetic-desktop-standard
```

## 動作確認

事前にROS通信用のネットワークを作成する．

```bash
$ docker network create rosnet
```

### roscoreの起動

roscoreのコンテナを起動する．  
起動スクリプトは環境とROSのバージョンに応じて変更する．

```bash
$ cd /path/to/docker-ros/
$ ./run.kinetic.standard --name roscore --net rosnet
Usage:
./run.kinetic.standard [OPTIONS]

OPTIONS: --name ros_test
```

ホームディレクトリの権限を修正する．
```bash
$ sudo chown -R $USER:$USER .
```

roscoreを起動する．

```bash
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

### rvisの起動

rvizのコンテナを起動する．  
`ROS_MASTER_URI=http://foobar:port/`を環境変数として指定して起動する．  
起動スクリプトは環境とROSのバージョンに応じて変更する．

```bash
$ cd /path/to/docker-ros/
$ ./run.kinetic.standard --name rviz --net rosnet --env ROS_HOSTNAME=rviz --env ROS_MASTER_URI=http://6f6412fba6a4:11311/
Usage:
./run.kinetic.standard [OPTIONS]

OPTIONS: --name rviz --net rosnet --env ROS_HOSTNAME=rviz --env ROS_MASTER_URI=http://6f6412fba6a4:11311/
```

ホームディレクトリの権限を修正する．
```bash
$ sudo chown -R $USER:$USER .
```

rvizを起動する．

```bash
$ rosrun rviz rviz
[ INFO] [1542009344.854182363]: rviz version 1.12.16
[ INFO] [1542009344.854230633]: compiled against Qt version 5.5.1
[ INFO] [1542009344.854240831]: compiled against OGRE version 1.9.0 (Ghadamon)
[ INFO] [1542009345.366723839]: Stereo is NOT SUPPORTED
[ INFO] [1542009345.366854568]: OpenGl version: 4.5 (GLSL 4.5).
```

rvizが立ち上がればOK．
