#!/bin/bash

# Usage
if [ "${1}" != "build" ] && [ "${1}" != "run" ] && [ "${1}" != "stop" ] && [ "${1}" != "remove" ] && [ "${1}" != "ssh" ]; then
  echo "Usage: ./docker.sh build | run | stop | remove | ssh"
  exit
fi

readonly DOCKER_TAG=wp
readonly DOCKER_NAME=mywordpress
readonly DOCKER_PORT=5000

if [ "${1}" == "build" ]; then

    docker build --no-cache -t $DOCKER_TAG .

elif [ "${1}" == "run" ]; then

    docker run -d -it -p 80:$DOCKER_PORT --name $DOCKER_NAME $DOCKER_TAG

elif [ "${1}" == "stop" ]; then

    CONTAINER=$(docker ps -qf name="$DOCKER_NAME")
    docker stop $CONTAINER

elif [ "${1}" == "remove" ]; then

    CONTAINER=$(docker ps -qf name="$DOCKER_NAME")
    docker rm $CONTAINER

elif [ "${1}" == "ssh" ]; then

    CONTAINER=$(docker ps -qf name="$DOCKER_NAME")
    docker exec -it $CONTAINER /bin/bash

fi
