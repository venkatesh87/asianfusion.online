#!/bin/sh

source ./functions.sh

BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  BRANCH=$1
fi

readonly HOST=$(jq -r ".${BRANCH}.endpoint" ./db.json)
readonly DATABASE=$(jq -r ".${BRANCH}.database" ./db.json)
readonly USER=$(jq -r ".${BRANCH}.user" ./db.json)
readonly PASSWORD=$(jq -r ".${BRANCH}.password" ./db.json)
readonly PORT=$(jq -r ".${BRANCH}.port" ./db.json)
readonly SQL_FILE=${DATABASE}.sql

if [ "$HOST" == null ]; then
  echo "Database not found for '$BRANCH' branch, wrong branch?"
  exit
fi

echo Dumping SQL file $SQL_FILE from $HOST...

no_pw_warning mysqldump -h$HOST -u$USER -p$PASSWORD -P$PORT $DATABASE > $SQL_FILE

echo Dumped
