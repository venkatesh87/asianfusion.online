#!/bin/sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly HOST=$(jq -r ".${APP_BRANCH}.endpoint" ./db.json)
readonly DATABASE=$(jq -r ".${APP_BRANCH}.database" ./db.json)
readonly USER=$(jq -r ".${APP_BRANCH}.user" ./db.json)
readonly PASSWORD=$(jq -r ".${APP_BRANCH}.password" ./db.json)

echo Please wait...
mysqldump -h$HOST -u$USER -p$PASSWORD $DATABASE > $DATABASE.sql 2>/dev/null | grep -v "mysql: [Warning] Using a password on the command line interface can be insecure."
echo SQL file ${DATABASE}.sql dumped
