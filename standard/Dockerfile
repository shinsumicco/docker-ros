FROM osrf/ros:kinetic-desktop-full

# install the minumum packages 
RUN apt update
RUN apt upgrade -y
RUN apt install -y git vim bash-completion

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
