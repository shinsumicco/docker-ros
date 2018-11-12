#!/bin/bash

echo "Usage:"
echo "./run.bash [OPTIONS]"
echo ""

# 第1引数以降を繋げる
OPTIONS=""
for x in "$@"
do
    OPTIONS="$OPTIONS $x"
done

echo "OPTIONS:$OPTIONS"
echo ""

XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

docker run -it \
    --user=$(id -u):$(id -g) \
    --env=DISPLAY=$DISPLAY \
    --env=QT_X11_NO_MITSHM=1 \
    --workdir="/home/$USER" \
    --volume="/home/$USER:/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --runtime=nvidia \
    --rm \
    $OPTIONS \
    ros:kinetic-desktop-nvidia \
    /bin/bash
