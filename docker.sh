#!/bin/bash

# Usage
if [ "${1}" != "build" ] && [ "${1}" != "run" ] && [ "${1}" != "stop" ] && [ "${1}" != "remove" ] && [ "${1}" != "ssh" ]; then
  echo "Usage: ./docker.sh build | run | stop | remove | ssh"
  exit
fi

readonly DOCKER_NAME=mywordpress
CONTAINER=$(docker ps -qf name="$DOCKER_NAME")

# Build
if [ "${1}" == "build" ]; then

    docker build -t $DOCKER_NAME .

elif [ "${1}" == "run" ]; then

    docker run -d $DOCKER_NAME

elif [ "${1}" == "stop" ]; then

    docker stop $CONTAINER

elif [ "${1}" == "remove" ]; then

    docker rm $CONTAINER

elif [ "${1}" == "ssh" ]; then

    docker exec -it $CONTAINER /bin/bash

fi
