#!/bin/sh

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
mysql -h$HOST -u$USER -p$PASSWORD $DATABASE < "$SQL_FILE" 2>/dev/null | grep -v "mysql: [Warning] Using a password on the command line interface can be insecure."
echo SQL file loaded
