#!/bin/bash

# Usage
if [ "${1}" != "build" ] && [ "${1}" != "remove" ] && [ "${1}" != "ssh" ]; then
  echo "Usage: ./docker.sh build | remove | ssh"
  exit
fi

readonly WP_DIR=$(jq -r ".publicWebDir" ./app.json)
readonly WP_NAME=$(jq -r ".docker.wordpress.name" ./app.json)
readonly WP_PORT=$(jq -r ".docker.wordpress.port" ./app.json)
readonly LOCAL_MYSQL_PORT=$(jq -r ".docker.mysql.port" ./app.json)
readonly LOCAL_MYSQL_ROOT_PASSWORD=$(jq -r ".docker.mysql.rootPassword" ./app.json)
readonly PHPMYADMIN_PORT=$(jq -r ".docker.phpmyadmin.port" ./app.json)
readonly PHPMYADMIN_CONNECT_LOCAL_MYSQL=$(jq -r ".docker.phpmyadmin.connectLocalMysql" ./app.json)

PHPMYADMIN_MYSQL_HOST=$(jq -r ".root.endpoint" ./db.json)
PHPMYADMIN_MYSQL_PORT=3306
PHPMYADMIN_ARBITRARY=0

if [ "$PHPMYADMIN_CONNECT_LOCAL_MYSQL" -eq 1 ]; then
  #PHPMYADMIN_MYSQL_HOST=${WP_NAME}_mysql
  PHPMYADMIN_MYSQL_HOST=mysql
  PHPMYADMIN_MYSQL_PORT=$LOCAL_MYSQL_PORT
fi

cp docker-compose.sample.yml docker-compose.yml

sed -i '' -e "s/{WP_NAME}/${WP_NAME}/g" ./docker-compose.yml
sed -i '' -e "s/{WP_DIR}/${WP_DIR}/g" ./docker-compose.yml
sed -i '' -e "s/{WP_PORT}/${WP_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{LOCAL_MYSQL_PORT}/${LOCAL_MYSQL_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{LOCAL_MYSQL_ROOT_PASSWORD}/${LOCAL_MYSQL_ROOT_PASSWORD}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_PORT}/${PHPMYADMIN_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_MYSQL_HOST}/${PHPMYADMIN_MYSQL_HOST}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_MYSQL_PORT}/${PHPMYADMIN_MYSQL_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_ARBITRARY}/${PHPMYADMIN_ARBITRARY}/g" ./docker-compose.yml

if [ "${1}" == "build" ]; then

    docker-compose up -d --build

elif [ "${1}" == "remove" ]; then

    WP=$(docker ps -qf name="${WP_NAME}_wordpress")
    LOCAL_MYSQL=$(docker ps -qf name="${WP_NAME}_mysql")
    PHPMYADMIN=$(docker ps -qf name="${WP_NAME}_phpmyadmin")

    docker rm -f $WP
    docker rm -f $LOCAL_MYSQL
    docker rm -f $PHPMYADMIN

elif [ "${1}" == "ssh" ]; then

    CONTAINER=$(docker ps -qf name="$WP_NAME")
    docker exec -it $CONTAINER /bin/bash

fi
