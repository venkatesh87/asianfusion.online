#!/bin/bash

# Usage
if [ "${1}" != "build" ] && [ "${1}" != "remove" ] && [ "${1}" != "ssh" ] && [ "${1}" != "ssh-phpmyadmin" ] && [ "${1}" != "ssh-mysql" ]; then
  echo "Usage: ./docker.sh build | remove | ssh | ssh-phpmyadmin | ssh-mysql"
  exit
fi

readonly WP_DIR=$(jq -r ".publicWebDir" ./app.json)
readonly WP_NAME=$(jq -r ".docker.wordpress.name" ./app.json)
readonly WP_PORT=$(jq -r ".docker.wordpress.port" ./app.json)
readonly LOCAL_MYSQL_USERNAME=$(jq -r ".docker.mysql.username" ./app.json)
readonly LOCAL_MYSQL_PASSWORD=$(jq -r ".docker.mysql.password" ./app.json)
readonly LOCAL_MYSQL_PORT=$(jq -r ".docker.mysql.port" ./app.json)
readonly PHPMYADMIN_PORT=$(jq -r ".docker.phpmyadmin.port" ./app.json)
readonly CONNECT_LOCAL_MYSQL_FOR_DEV=$(jq -r ".connectLocalMysqlForDev" ./app.json)

PHPMYADMIN_ARBITRARY=0
PHPMYADMIN_MYSQL_PORT=3306
# phpMyAdmin - Point to MySQL in AWS
PHPMYADMIN_MYSQL_HOST=$(jq -r ".root.endpoint" ./db.json)

# phpMyAdmin - Point to MySQL on local
if [ "$CONNECT_LOCAL_MYSQL_FOR_DEV" -eq 1 ]; then
  # MySQL container name
  PHPMYADMIN_MYSQL_HOST=${WP_NAME}_mysql
fi

cp docker-compose.sample.yml docker-compose.yml

sed -i '' -e "s/{WP_NAME}/${WP_NAME}/g" ./docker-compose.yml
sed -i '' -e "s/{WP_DIR}/${WP_DIR}/g" ./docker-compose.yml
sed -i '' -e "s/{WP_PORT}/${WP_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{LOCAL_MYSQL_USERNAME}/${LOCAL_MYSQL_USERNAME}/g" ./docker-compose.yml
sed -i '' -e "s/{LOCAL_MYSQL_PASSWORD}/${LOCAL_MYSQL_PASSWORD}/g" ./docker-compose.yml
sed -i '' -e "s/{LOCAL_MYSQL_PORT}/${LOCAL_MYSQL_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_PORT}/${PHPMYADMIN_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_MYSQL_HOST}/${PHPMYADMIN_MYSQL_HOST}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_MYSQL_PORT}/${PHPMYADMIN_MYSQL_PORT}/g" ./docker-compose.yml
sed -i '' -e "s/{PHPMYADMIN_ARBITRARY}/${PHPMYADMIN_ARBITRARY}/g" ./docker-compose.yml

if [ "${1}" == "build" ]; then

    docker-compose up -d --build

    # Make sure wp-config.php is up to date                                         
    sh ./post-checkout

elif [ "${1}" == "remove" ]; then

    docker rm -f ${WP_NAME}_wordpress
    docker rm -f ${WP_NAME}_mysql
    docker rm -f ${WP_NAME}_phpmyadmin

elif [ "${1}" == "ssh" ]; then

    docker exec -it ${WP_NAME}_wordpress /bin/sh

elif [ "${1}" == "ssh-phpmyadmin" ]; then

    docker exec -it ${WP_NAME}_phpmyadmin /bin/sh

elif [ "${1}" == "ssh-mysql" ]; then

    docker exec -it ${WP_NAME}_mysql /bin/sh

fi
