#!/bin/sh

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$APP_BRANCH" != "qa" ]; then
  echo "You're not on qa branch"
  exit
fi

readonly QA_HOST=$(jq -r ".${APP_BRANCH}.endpoint" ./db.json)
readonly QA_DATABASE=$(jq -r ".${APP_BRANCH}.database" ./db.json)
readonly QA_USER=$(jq -r ".${APP_BRANCH}.user" ./db.json)
readonly QA_PASSWORD=$(jq -r ".${APP_BRANCH}.password" ./db.json)

readonly LIVE_HOST=$(jq -r ".${APP_BRANCH}.endpoint" ./db.json)
readonly LIVE_DATABASE=$(jq -r ".${APP_BRANCH}.database" ./db.json)
readonly LIVE_USER=$(jq -r ".${APP_BRANCH}.user" ./db.json)
readonly LIVE_PASSWORD=$(jq -r ".${APP_BRANCH}.password" ./db.json)

readonly SQL_FILE=/tmp/${DATABASE}-${APP_BRANCH}.sql

mysqldump -h$QA_HOST -u$QA_USER -p$QA_PASSWORD $QA_DATABASE > "$SQL_FILE"

mysql -h$LIVE_HOST -u$LIVE_USER -p$LIVE_PASSWORD $LIVE_DATABASE < "$SQL_FILE"
