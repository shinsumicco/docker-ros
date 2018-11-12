FROM nvidia/opengl:1.1-glvnd-devel-ubuntu16.04

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# install the minumum packages
RUN apt update
RUN apt upgrade -y
RUN apt install -yq git vim bash-completion
RUN apt install -yq dirmngr gnupg2 lsb-release

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt install --no-install-recommends -yq python-rosdep python-rosinstall python-vcstools

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN rosdep init
RUN rosdep update

# install ros packages
ENV ROS_DISTRO kinetic
RUN apt update
RUN apt upgrade -y
RUN apt install -yq ros-kinetic-desktop-full=1.3.2-0*

# install user packages here
RUN apt install -yq build-essential

# remove caches
RUN apt autoremove -y
RUN apt clean -y
RUN rm -rf /var/lib/apt/lists/

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod 777 /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
