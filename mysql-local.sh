#!/bin/bash

source ./variables.sh

readonly LOCAL_MYSQL_USERNAME=$(jq -r ".docker.mysql.username" $APP_CONFIG_FILE)
readonly LOCAL_MYSQL_PASSWORD=$(jq -r ".docker.mysql.password" $APP_CONFIG_FILE)
readonly LOCAL_MYSQL_PORT=$(jq -r ".docker.mysql.port" $APP_CONFIG_FILE)

mysql -h127.0.0.1 -u${LOCAL_MYSQL_USERNAME} -p${LOCAL_MYSQL_PASSWORD} -P${LOCAL_MYSQL_PORT}
