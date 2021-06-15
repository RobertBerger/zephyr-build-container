#!/bin/bash
source ../container-name.sh

if [ $# -lt 1 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <CONTAINER_NAME>"
    echo "+ $0 reslocal/${CONTAINER_NAME}:${TAG}"
    exit
fi

IMAGE="$1"

pushd ..
set -x
#docker build --no-cache --rm=true -t ${IMAGE} .
#docker build -f Dockerfile.user --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t zephyr-build:v${2tag} .
docker build -f Dockerfile.user --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t $1 .
set +x
popd
