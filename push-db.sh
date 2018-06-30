#!/bin/sh

source ./variables.sh
source ./functions.sh

if [[ $# -eq 0 ]] ; then
  echo "Missing the origin and destination branch parameters"
  exit
fi

readonly ORIGIN_BRANCH=$1
readonly DEST_BRANCH=$2

readonly ORIGIN_HOST=$(jq -r ".${ORIGIN_BRANCH}.endpoint" $DB_CONFIG_FILE)
readonly ORIGIN_DATABASE=$(jq -r ".${ORIGIN_BRANCH}.database" $DB_CONFIG_FILE)
readonly ORIGIN_USER=$(jq -r ".${ORIGIN_BRANCH}.user" $DB_CONFIG_FILE)
readonly ORIGIN_PASSWORD=$(jq -r ".${ORIGIN_BRANCH}.password" $DB_CONFIG_FILE)
readonly ORIGIN_PORT=$(jq -r ".${ORIGIN_BRANCH}.port" $DB_CONFIG_FILE)

readonly DEST_HOST=$(jq -r ".${DEST_BRANCH}.endpoint" $DB_CONFIG_FILE)
readonly DEST_DATABASE=$(jq -r ".${DEST_BRANCH}.database" $DB_CONFIG_FILE)
readonly DEST_USER=$(jq -r ".${DEST_BRANCH}.user" $DB_CONFIG_FILE)
readonly DEST_PASSWORD=$(jq -r ".${DEST_BRANCH}.password" $DB_CONFIG_FILE)
readonly DEST_PORT=$(jq -r ".${DEST_BRANCH}.port" $DB_CONFIG_FILE)

readonly SQL_FILE=${TMP}/${APP_NAME}-${ORIGIN_BRANCH}.sql

if [ "$ORIGIN_HOST" == null ]; then
  echo "Database not found for origin branch '$ORIGIN_BRANCH', wrong branch?"
  exit
fi

if [ "$DEST_HOST" == null ]; then
  echo "Database not found for destination branch '$DEST_BRANCH', wrong branch?"
  exit
fi

echo Dumping SQL file $SQL_FILE from $ORIGIN_HOST
no_pw_warning mysqldump -h$ORIGIN_HOST -u$ORIGIN_USER -p$ORIGIN_PASSWORD -P$ORIGIN_PORT $ORIGIN_DATABASE > "$SQL_FILE"

echo Loading SQL file $SQL_FILE to destination database $DEST_HOST
no_pw_warning mysql -h$DEST_HOST -u$DEST_USER -p$DEST_PASSWORD -P$DEST_PORT $DEST_DATABASE < "$SQL_FILE"

echo Done
