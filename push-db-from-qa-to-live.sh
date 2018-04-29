#!/bin/sh

source ./functions.sh

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly APP_NAME=$(jq -r ".appName" ./app.json)

if [ "$APP_BRANCH" != "qa" ]; then
  echo "You're not on qa branch"
  exit
fi

readonly QA_HOST=$(jq -r ".qa.endpoint" ./db.json)
readonly QA_DATABASE=$(jq -r ".qa.database" ./db.json)
readonly QA_USER=$(jq -r ".qa.user" ./db.json)
readonly QA_PASSWORD=$(jq -r ".qa.password" ./db.json)

readonly LIVE_HOST=$(jq -r ".master.endpoint" ./db.json)
readonly LIVE_DATABASE=$(jq -r ".master.database" ./db.json)
readonly LIVE_USER=$(jq -r ".master.user" ./db.json)
readonly LIVE_PASSWORD=$(jq -r ".master.password" ./db.json)

readonly SQL_FILE=/tmp/${APP_NAME}-qa.sql

echo Please wait...

echo Dumping...
no_pw_warning mysqldump -h$QA_HOST -u$QA_USER -p$QA_PASSWORD $QA_DATABASE > "$SQL_FILE"

echo Loading...
no_pw_warning mysql -h$LIVE_HOST -u$LIVE_USER -p$LIVE_PASSWORD $LIVE_DATABASE < "$SQL_FILE"

echo Done
