#!/bin/sh

source ./variables.sh
source ./functions.sh

if [[ $# -eq 0 ]] ; then
  echo "Missing a SQL file parameter"
  exit
fi

readonly SQL_FILE=$1
BRANCH=$2

if [ "$BRANCH" == "" ] ; then
  BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
fi

readonly ENV_NAME=${APP_NAME}-${BRANCH}
readonly HOST=$(jq -r ".${BRANCH}.endpoint" ./db.json)
readonly DATABASE=$(jq -r ".${BRANCH}.database" ./db.json)
readonly USER=$(jq -r ".${BRANCH}.user" ./db.json)
readonly PASSWORD=$(jq -r ".${BRANCH}.password" ./db.json)
readonly PORT=$(jq -r ".${BRANCH}.port" ./db.json)

echo Loading SQL file $SQL_FILE to $HOST for $ENV_NAME

no_pw_warning mysql -h$HOST -u$USER -p$PASSWORD -P$PORT $DATABASE < "$SQL_FILE"

echo Loaded
