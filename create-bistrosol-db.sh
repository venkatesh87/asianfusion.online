#!/bin/bash

source ./functions.sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly DB_JSON_FILE=bistrosol-${APP_BRANCH}.json

readonly ROOT_DB_HOST=$(jq -r ".root.endpoint" ./db.json)
readonly ROOT_DB_USER=$(jq -r ".root.user" ./db.json)
readonly ROOT_DB_PASSWORD=$(jq -r ".root.password" ./db.json)
readonly ROOT_DB_PORT=$(jq -r ".root.port" ./db.json)

readonly BISTROSOL_DB_DATABASE=bistrosolutions_${APP_BRANCH}
readonly BISTROSOL_DB_USER=replcation
readonly BISTROSOL_DB_PASSWORD=$(get_password)

no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "DROP DATABASE IF EXISTS $BISTROSOL_DB_DATABASE;"
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE DATABASE $BISTROSOL_DB_DATABASE;"
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE USER IF NOT EXISTS '$BISTROSOL_DB_USER'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD' REQUIRE SSL;"
# If user password changed
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "ALTER USER '$BISTROSOL_DB_USER'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD' REQUIRE SSL;"
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "GRANT ALL PRIVILEGES ON $BISTROSOL_DB_DATABASE.* TO '$BISTROSOL_DB_USER'@'%';"

# Flush privileges
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "FLUSH PRIVILEGES;"


echo Created database $BISTROSOL_DB_DATABASE

# Generate db.json file
echo "{
  \"endpoint\": \"$ROOT_DB_HOST\",
  \"database\": \"$BISTROSOL_DB_DATABASE\",
  \"user\": \"$BISTROSOL_DB_USER\",
  \"password\": \"$BISTROSOL_DB_PASSWORD\",
  \"port\": \"$ROOT_DB_PORT\"
}" > $DB_JSON_FILE

echo
echo ================================
echo Bistrosolutions database has been created.
echo Check $DB_JSON_FILE for database access info
echo ================================
echo
