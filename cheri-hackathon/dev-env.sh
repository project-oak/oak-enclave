#!/bin/bash -e
# This script builds a docker container with dev. environment on demand and runs specified shells command there.
THIS_SCRIPT=`realpath $0`
REPO_DIR=`dirname $THIS_SCRIPT`
DOCKERFILE_DIR=$REPO_DIR/build-scripts
[ -f /.dev-env ] && { echo "You are already inside the dev-env shell!"; exit 1; }
# Avoiding re-building docker image if already present
IMAGE=cherihackaton-`sha256sum ${DOCKERFILE_DIR}/Dockerfile | awk '{print $1}'`
docker inspect ${IMAGE} >/dev/null 2>&1 || \
    docker build --build-arg USER_ID=${UID} --build-arg USER_GID=`id -g` -t ${IMAGE} ${DOCKERFILE_DIR}
# Running specified command inside container. If not specified then interactive bash shell will run.
# Current directory will be mounted as ~/workdir inside docker container.
exec docker run --rm -ti \
  --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
  -v ${PWD}:/home/dev/workdir \
  ${IMAGE} "$@"

