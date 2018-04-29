#!/bin/sh

source ./functions.sh

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

readonly LIVE_HOST=$(jq -r ".master.endpoint" ./db.json)
readonly LIVE_DATABASE=$(jq -r ".master.database" ./db.json)
readonly LIVE_USER=$(jq -r ".master.user" ./db.json)
readonly LIVE_PASSWORD=$(jq -r ".master.password" ./db.json)

readonly SQL_FILE=/tmp/${APP_NAME}-dev.sql

echo Please wait...

echo Dumping...
no_pw_warning mysqldump -h$DEV_HOST -u$DEV_USER -p$DEV_PASSWORD $DEV_DATABASE > "$SQL_FILE"

echo Loading...
no_pw_warning mysql -h$LIVE_HOST -u$LIVE_USER -p$LIVE_PASSWORD $LIVE_DATABASE < "$SQL_FILE"

echo Done
