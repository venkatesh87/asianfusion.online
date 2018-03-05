#!/bin/bash

# Usage
if [ "${1}" != "build" ] && [ "${1}" != "run" ] && [ "${1}" != "remove" ] && [ "${1}" != "ssh" ]; then
  echo "Usage: ./docker.sh build | run | remove | ssh"
  exit
fi

readonly DOCKER_TAG=wp
readonly DOCKER_NAME=mywordpress
readonly DOCKER_PORT=8500

if [ "${1}" == "build" ]; then

    docker build --no-cache -t $DOCKER_TAG .

elif [ "${1}" == "run" ]; then

    docker run -d -v ${PWD}/src:/var/www/html -p $DOCKER_PORT:80 --name $DOCKER_NAME $DOCKER_TAG

elif [ "${1}" == "remove" ]; then

    CONTAINER=$(docker ps -qf name="$DOCKER_NAME")
    docker rm -f $CONTAINER

elif [ "${1}" == "ssh" ]; then

    CONTAINER=$(docker ps -qf name="$DOCKER_NAME")
    docker exec -it $CONTAINER /bin/bash

fi
