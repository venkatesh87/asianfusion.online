#!/bin/sh

source ./functions.sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly HOST=$(jq -r ".${APP_BRANCH}.endpoint" ./db.json)
readonly DATABASE=$(jq -r ".${APP_BRANCH}.database" ./db.json)
readonly USER=$(jq -r ".${APP_BRANCH}.user" ./db.json)
readonly PASSWORD=$(jq -r ".${APP_BRANCH}.password" ./db.json)

echo Please wait...

no_pw_warning mysqldump -h$HOST -u$USER -p$PASSWORD $DATABASE > $DATABASE.sql

echo SQL file ${DATABASE}.sql dumped
