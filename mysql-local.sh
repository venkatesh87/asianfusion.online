#!/bin/bash

readonly LOCAL_MYSQL_USERNAME=$(jq -r ".docker.mysql.username" app.json)
readonly LOCAL_MYSQL_PASSWORD=$(jq -r ".docker.mysql.password" app.json)
readonly LOCAL_MYSQL_PORT=$(jq -r ".docker.mysql.port" app.json)

mysql -h127.0.0.1 -u${LOCAL_MYSQL_USERNAME} -p${LOCAL_MYSQL_PASSWORD} -P${LOCAL_MYSQL_PORT}
