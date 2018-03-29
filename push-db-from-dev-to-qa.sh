#!/bin/sh

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly APP_NAME=$(jq -r ".appName" ./app.json)

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

readonly DEV_HOST=$(jq -r ".dev.endpoint" ./db.json)
readonly DEV_DATABASE=$(jq -r ".dev.database" ./db.json)
readonly DEV_USER=$(jq -r ".dev.user" ./db.json)
readonly DEV_PASSWORD=$(jq -r ".dev.password" ./db.json)

readonly QA_HOST=$(jq -r ".qa.endpoint" ./db.json)
readonly QA_DATABASE=$(jq -r ".qa.database" ./db.json)
readonly QA_USER=$(jq -r ".qa.user" ./db.json)
readonly QA_PASSWORD=$(jq -r ".qa.password" ./db.json)

readonly SQL_FILE=/tmp/${APP_NAME}-dev.sql

mysqldump -h$DEV_HOST -u$DEV_USER -p$DEV_PASSWORD $DEV_DATABASE > "$SQL_FILE"

mysql -h$QA_HOST -u$QA_USER -p$QA_PASSWORD $QA_DATABASE < "$SQL_FILE"
