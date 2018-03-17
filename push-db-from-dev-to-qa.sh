#!/bin/sh

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

readonly DEV_HOST=$(jq -r ".${APP_BRANCH}.endpoint" ./db.json)
readonly DEV_DATABASE=$(jq -r ".${APP_BRANCH}.database" ./db.json)
readonly DEV_USER=$(jq -r ".${APP_BRANCH}.user" ./db.json)
readonly DEV_PASSWORD=$(jq -r ".${APP_BRANCH}.password" ./db.json)

readonly QA_HOST=$(jq -r ".${APP_BRANCH}.endpoint" ./db.json)
readonly QA_DATABASE=$(jq -r ".${APP_BRANCH}.database" ./db.json)
readonly QA_USER=$(jq -r ".${APP_BRANCH}.user" ./db.json)
readonly QA_PASSWORD=$(jq -r ".${APP_BRANCH}.password" ./db.json)

readonly SQL_FILE=/tmp/${DATABASE}-${APP_BRANCH}.sql

mysqldump -h$DEV_HOST -u$DEV_USER -p$DEV_PASSWORD $DEV_DATABASE > "$SQL_FILE"

mysql -h$QA_HOST -u$QA_USER -p$QA_PASSWORD $QA_DATABASE < "$SQL_FILE"
