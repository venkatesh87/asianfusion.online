#!/bin/sh

source ./functions.sh

BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  BRANCH=$1
fi

HOST=$(jq -r ".${BRANCH}.endpoint" ./db.json)
DATABASE=$(jq -r ".${BRANCH}.database" ./db.json)
USER=$(jq -r ".${BRANCH}.user" ./db.json)
PASSWORD=$(jq -r ".${BRANCH}.password" ./db.json)
PORT=$(jq -r ".${BRANCH}.port" ./db.json)
SQL_FILE=${DATABASE}.sql

if [ "$BRANCH" == "local" ]; then
  DATABASE=$(jq -r ".rds.instanceName" ./app.json)
  HOST=localhost
  USER=wordpress
  PASSWORD=wordpress
  PORT=3306
  SQL_FILE=${DATABASE}_local.sql
fi

if [ "$HOST" == null ]; then
  echo "Database not found for '$BRANCH' branch, wrong branch?"
  exit
fi

echo Dumping SQL file $SQL_FILE from $HOST...

no_pw_warning mysqldump -h$HOST -u$USER -p$PASSWORD -P$PORT $DATABASE > $SQL_FILE

echo Dumped
