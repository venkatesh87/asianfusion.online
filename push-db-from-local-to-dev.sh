#!/bin/sh

source ./functions.sh

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly APP_NAME=$(jq -r ".appName" ./app.json)

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

readonly LOCAL_HOST=127.0.0.1
readonly LOCAL_DATABASE=${APP_NAME}_local
readonly LOCAL_USER=$(jq -r ".docker.mysql.username" ./app.json)
readonly LOCAL_PASSWORD=$(jq -r ".docker.mysql.password" ./app.json)
readonly LOCAL_PORT=$(jq -r ".docker.mysql.port" ./app.json)

readonly DEV_HOST=$(jq -r ".dev.endpoint" ./db.json)
readonly DEV_DATABASE=$(jq -r ".dev.database" ./db.json)
readonly DEV_USER=$(jq -r ".dev.user" ./db.json)
readonly DEV_PASSWORD=$(jq -r ".dev.password" ./db.json)

readonly SQL_FILE=/tmp/${APP_NAME}-local.sql

echo Please wait...

echo Dumping...
no_pw_warning mysqldump -h$LOCAL_HOST -u$LOCAL_USER -p$LOCAL_PASSWORD -P$LOCAL_PORT $LOCAL_DATABASE > "$SQL_FILE"

echo Loading...
no_pw_warning mysql -h$DEV_HOST -u$DEV_USER -p$DEV_PASSWORD $DEV_DATABASE < "$SQL_FILE"

echo Done
