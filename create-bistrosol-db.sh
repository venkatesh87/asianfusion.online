#!/bin/bash

source ./functions.sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" ./app.json)
readonly S3_SQL_PATH=s3://bistrosolutions/databases
readonly S3_SQL_FILE=bistrosolutions.sql
readonly S3_SQL_FILE_DOWNLOAD_TO=/tmp/${S3_SQL_FILE}

readonly BISTROSOL_DB_NAME=bistrosolutions
readonly BISTROSOL_DB_DATABASE=${BISTROSOL_DB_NAME}_${APP_BRANCH}
readonly BISTROSOL_DB_USER=replication
readonly BISTROSOL_DB_PASSWORD=$(get_password)

readonly ROOT_DB_HOST=$(jq -r ".root.endpoint" ./db.json)
readonly ROOT_DB_USER=$(jq -r ".root.user" ./db.json)
readonly ROOT_DB_PASSWORD=$(jq -r ".root.password" ./db.json)
readonly ROOT_DB_PORT=$(jq -r ".root.port" ./db.json)

readonly DB_JSON_FILE=${BISTROSOL_DB_NAME}-${APP_BRANCH}.json

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

echo Downloading database
aws s3 cp --profile $AWS_PROFILE ${S3_SQL_PATH}/${S3_SQL_FILE} $S3_SQL_FILE_DOWNLOAD_TO

# Replace database name in SQL
LC_ALL=C sed -i '' -e "s/\`${BISTROSOL_DB_NAME}\`/\`${BISTROSOL_DB_NAME}_${APP_BRANCH}\`/g" $S3_SQL_FILE_DOWNLOAD_TO

echo Loading database
#no_pw_warning
mysql -h$ROOT_DB_HOST -u$BISTROSOL_DB_USER \
  -p$BISTROSOL_DB_PASSWORD -P$ROOT_DB_PORT < $S3_SQL_FILE_DOWNLOAD_TO

# Generate db.json file
echo "{
  \"${BISTROSOL_DB_USER}\": {
    \"endpoint\": \"$ROOT_DB_HOST\",
    \"database\": \"$BISTROSOL_DB_DATABASE\",
    \"user\": \"$BISTROSOL_DB_USER\",
    \"password\": \"$BISTROSOL_DB_PASSWORD\",
    \"port\": \"$ROOT_DB_PORT\"
  }
}" > $DB_JSON_FILE

echo
echo ================================
echo Bistrosolutions database has been created.
echo Check $DB_JSON_FILE for database access info
echo ================================
echo
