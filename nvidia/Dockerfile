FROM nvidia/opengl:1.1-glvnd-devel-ubuntu16.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS yes

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# install the minumum packages
RUN set -x && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends && \
  : "install the minumum packages " && \
  apt-get install -yq --no-install-recommends git vim bash-completion && \
  apt-get install -yq --no-install-recommends dirmngr gnupg2 lsb-release && \
  : "remove caches" && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/

# install bootstrap tools
RUN set -x && \
  : "setup keys" && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116 && \
  : "setup sources.list" && \
  echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends && \
  : "install bootstrap tools" && \
  apt-get install -yq --no-install-recommends --allow-unauthenticated python-rosdep python-rosinstall python-vcstools && \
  : "remove caches" && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN set -x && \
  rosdep init && \
  rosdep update

# install ros packages
ENV ROS_DISTRO kinetic
RUN set -x && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends && \
  : "install ros packages" && \
  apt-get install -yq --no-install-recommends --allow-unauthenticated ros-kinetic-desktop-full=1.3.2-0* && \
  : "remove caches" && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/

# install user packages
RUN set -x && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends --allow-unauthenticated && \
  : "install user packages" && \
  apt-get install -yq --no-install-recommends sudo build-essential && \
  : "remove caches" && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod 777 /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
