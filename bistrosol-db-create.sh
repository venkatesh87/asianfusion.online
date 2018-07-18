#!/bin/bash

#
# Need to enable functions, procedures and triggers in RDS
# https://aws.amazon.com/premiumsupport/knowledge-center/rds-mysql-functions/
#
# This script does following:
# 1. Create database `bistrosolutions_{branch}`
# 2. Create user `bistrosolutions_{branch}_replication`
# 3. Create user `bistrosolutions_{branch}_web`
# 4. Download latest database SQL from S3
# 5. Search replace on SQL using `sed` (replace database name and remove DEFINER)
# 6. Load database
# 7. Export `${APP_NAME}-{branch}.json`

source ./functions.sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" ./app.json)
readonly APP_NAME=$(jq -r ".appName" ./app.json)
readonly S3_SQL_PATH=s3://bistrosolutions/databases
readonly S3_SQL_FILE=bistrosolutions.sql
readonly S3_SQL_FILE_DOWNLOAD_TO=/tmp/${S3_SQL_FILE}
# The `DEFINER` in the export SQL, the user who created procedures
readonly EXPORT_DEFINER=terminal

readonly BISTROSOL_DB_NAME=$APP_NAME
readonly BISTROSOL_DB_DATABASE=${BISTROSOL_DB_NAME}_${APP_BRANCH}
readonly DB_JSON_FILE=${APP_NAME}-${APP_BRANCH}.json

# SSL
readonly BISTROSOL_DB_USER=${BISTROSOL_DB_NAME}_${APP_BRANCH}_replication
BISTROSOL_DB_PASSWORD=$(jq -r ".${BISTROSOL_DB_USER}.password" $DB_JSON_FILE)
# New password
if [ ! -f $DB_JSON_FILE ] || [ "$BISTROSOL_DB_PASSWORD" == null ]; then
  BISTROSOL_DB_PASSWORD=$(get_password)
fi

# Non-SSL
readonly BISTROSOL_DB_USER2=${BISTROSOL_DB_NAME}_${APP_BRANCH}_web
BISTROSOL_DB_PASSWORD2=$(jq -r ".${BISTROSOL_DB_USER2}.password" $DB_JSON_FILE)
# New password
if [ ! -f $DB_JSON_FILE ] || [ "$BISTROSOL_DB_PASSWORD2" == null ]; then
  BISTROSOL_DB_PASSWORD2=$(get_password)
fi

readonly ROOT_DB_HOST=$(jq -r ".root.endpoint" ./bistrosol-db.json)
readonly ROOT_DB_USER=$(jq -r ".root.user" ./bistrosol-db.json)
readonly ROOT_DB_PASSWORD=$(jq -r ".root.password" ./bistrosol-db.json)
readonly ROOT_DB_PORT=$(jq -r ".root.port" ./bistrosol-db.json)

# Drop database
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "DROP DATABASE IF EXISTS $BISTROSOL_DB_DATABASE;"

# Create database
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE DATABASE $BISTROSOL_DB_DATABASE;"

# Create replication user
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE USER IF NOT EXISTS '$BISTROSOL_DB_USER'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD' REQUIRE SSL;"

# Update replication user password
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "ALTER USER '$BISTROSOL_DB_USER'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD' REQUIRE SSL;"

# Grant privileges to replication user
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "GRANT ALL PRIVILEGES ON $BISTROSOL_DB_DATABASE.* TO '$BISTROSOL_DB_USER'@'%';"

# Create web user
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE USER IF NOT EXISTS '$BISTROSOL_DB_USER2'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD2';"

# Update web user password
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "ALTER USER '$BISTROSOL_DB_USER2'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD2';"

# Grant privileges to web user (web user has root privileges except GRANT)
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "GRANT ALL PRIVILEGES ON *.* TO '$BISTROSOL_DB_USER2'@'%';"

# Flush privileges
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "FLUSH PRIVILEGES;"

echo Created database $BISTROSOL_DB_DATABASE

echo Downloading database
aws s3 cp --profile $AWS_PROFILE ${S3_SQL_PATH}/${S3_SQL_FILE} $S3_SQL_FILE_DOWNLOAD_TO

# Replace database name in SQL (user `LC_ALL=C` to avoid error: illegal byte sequence)
LC_ALL=C sed -i '' -e "s/\`bistrosolutions\`/\`${BISTROSOL_DB_NAME}_${APP_BRANCH}\`/g" $S3_SQL_FILE_DOWNLOAD_TO

# Remove DEFINER
LC_ALL=C sed -i '' -e "s#/\*!50017 DEFINER=\`${EXPORT_DEFINER}\`@\`%\`\*/##g" $S3_SQL_FILE_DOWNLOAD_TO
LC_ALL=C sed -i '' -e "s#DEFINER=\`${EXPORT_DEFINER}\`@\`%\` ##g" $S3_SQL_FILE_DOWNLOAD_TO 

# Remove unsupported sql_mode in 8.0
LC_ALL=C sed -i '' -e "s#,NO_AUTO_CREATE_USER##g" $S3_SQL_FILE_DOWNLOAD_TO 

echo Loading database. This is going to take a while, please wait...

mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT < $S3_SQL_FILE_DOWNLOAD_TO

# Generate database json file
echo "{
  \"${BISTROSOL_DB_USER}\": {
    \"endpoint\": \"$ROOT_DB_HOST\",
    \"database\": \"$BISTROSOL_DB_DATABASE\",
    \"user\": \"$BISTROSOL_DB_USER\",
    \"password\": \"$BISTROSOL_DB_PASSWORD\",
    \"port\": \"$ROOT_DB_PORT\"
  },
  \"${BISTROSOL_DB_USER2}\": {
    \"endpoint\": \"$ROOT_DB_HOST\",
    \"database\": \"$BISTROSOL_DB_DATABASE\",
    \"user\": \"$BISTROSOL_DB_USER2\",
    \"password\": \"$BISTROSOL_DB_PASSWORD2\",
    \"port\": \"$ROOT_DB_PORT\"
  }
}" > $DB_JSON_FILE

echo
echo ================================
echo Bistrosolutions database has been created.
echo Check $DB_JSON_FILE for database access info
echo ================================
echo
