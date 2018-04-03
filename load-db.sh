#!/bin/sh

source ./functions.sh

if [[ $# -eq 0 ]] ; then
  echo "Missing a SQL file parameter"
  exit
fi

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly SQL_FILE=$1

readonly HOST=$(jq -r ".${APP_BRANCH}.endpoint" ./db.json)
readonly DATABASE=$(jq -r ".${APP_BRANCH}.database" ./db.json)
readonly USER=$(jq -r ".${APP_BRANCH}.user" ./db.json)
readonly PASSWORD=$(jq -r ".${APP_BRANCH}.password" ./db.json)

echo Please wait...

no_pw_warning mysql -h$HOST -u$USER -p$PASSWORD $DATABASE < "$SQL_FILE"

echo SQL file loaded
