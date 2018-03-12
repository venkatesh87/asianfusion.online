#!/bin/bash

# Usage
if [ "${1}" != "build" ] && [ "${1}" != "run" ] && [ "${1}" != "remove" ] && [ "${1}" != "ssh" ]; then
  echo "Usage: ./docker.sh build | run | remove | ssh"
  exit
fi

readonly DOCKER_NAME=$(jq -r ".docker.name" ./app.json)
readonly DOCKER_TAG=$(jq -r ".docker.tag" ./app.json)
readonly DOCKER_PORT=$(jq -r ".docker.port" ./app.json)
readonly PUBLIC_WEB_DIR=$(jq -r ".publicWebDir" ./app.json)

if [ "${1}" == "build" ]; then

    docker build --no-cache -t $DOCKER_TAG .

elif [ "${1}" == "run" ]; then

    docker run -d -v ${PWD}/${PUBLIC_WEB_DIR}:/var/www/html -p $DOCKER_PORT:80 --name $DOCKER_NAME $DOCKER_TAG

elif [ "${1}" == "remove" ]; then

    CONTAINER=$(docker ps -qf name="$DOCKER_NAME")
    docker rm -f $CONTAINER

elif [ "${1}" == "ssh" ]; then

    CONTAINER=$(docker ps -qf name="$DOCKER_NAME")
    docker exec -it $CONTAINER /bin/bash

fi
