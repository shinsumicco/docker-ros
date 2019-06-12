FROM osrf/ros:kinetic-desktop-full

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS yes

# update the installed packages
RUN set -x && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends --allow-unauthenticated && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/

# install packages
RUN set -x && \
  apt-get update && \
  : "install the minumum packages " && \
  apt-get install -yq --no-install-recommends git vim bash-completion && \
  : "install user packages" && \
  apt-get install -yq --no-install-recommends  build-essential && \
  : "remove caches" && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod 777 /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
