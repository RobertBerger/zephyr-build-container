source ../container-name.sh
SDKDIR="/home/${USER}/projects/sdk"

if [ $# -lt 1 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <docker image>" 
    echo "+ $0 reslocal/${CONTAINER_NAME}:${TAG}"
    exit
fi

IMAGE_NAME=$1

# remove currently running containers
set -x
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=$1)

docker ps -a
docker stop ${ID_TO_KILL}
docker rm -f ${ID_TO_KILL}
docker ps -a

# -t : Allocate a pseudo-tty
# -i : Keep STDIN open even if not attached
# -d : To start a container in detached mode, you use -d=true or just -d option.
# -p : publish port PUBLIC_PORT:INTERNAL_PORT
# -l : ??? without it no root@1928719827
# --cap-drop=all: drop all (root) capabilites

#docker run -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects -v /home/${USER}:/student -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${IMAGE_NAME} --login
set +x

# start ash shell - need to start telegraf manually
#set -x
#docker run --interactive --tty --entrypoint=/bin/bash ${IMAGE_NAME} --login
#set +x

set -x

if [ ! -d ${HOME}/projects/zephyrproject ]; then
   mkdir ${HOME}/projects/zephyrproject
fi

if [ ! -d ${HOME}/projects/zephyr-projects ]; then
   mkdir ${HOME}/projects/zephyr-projects
fi


#docker run -ti -v <path to zephyr workspace>:/workdir zephyr-build:v<tag>
#docker run -ti -v /workdir/sources/zephyr:/workdir ${1}
#docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb -v ${HOME}/projects/zephyr:/zephyr ${1}
#docker run --rm -it -v /dev/bus/usb:/dev/bus/usb -v ${HOME}/projects/zephyr:/workdir ${1}
#docker run --rm -it --device=/dev/ttyUSB_nucleo_f411re -v ${HOME}/projects/zephyr:/workdir ${1}
#docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb -v ${HOME}/projects/zephyr:/workdir ${1}
#docker run --rm -it \
#  --device-cgroup-rule='c 189:* rmw' \
#  -v /dev:/dev \
#  -v /dev/bus/usb:/dev/bus/usb \
#  -v ${HOME}/projects/zephyr:/workdir ${1}

docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb -v ${HOME}/projects/zephyrproject:/workdir -v ${HOME}/projects/zephyr-projects:/zephyr-projects ${1}
set +x
