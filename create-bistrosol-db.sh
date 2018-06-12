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
# 7. Export `bistrosolutions-{branch}.json`

source ./functions.sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" ./app.json)
readonly S3_SQL_PATH=s3://bistrosolutions/databases
readonly S3_SQL_FILE=bistrosolutions.sql
readonly S3_SQL_FILE_DOWNLOAD_TO=/tmp/${S3_SQL_FILE}
# The `DEFINER` in the export SQL, the user who created procedures
readonly EXPORT_DEFINER=terminal

readonly BISTROSOL_DB_NAME=bistrosolutions
readonly BISTROSOL_DB_DATABASE=${BISTROSOL_DB_NAME}_${APP_BRANCH}

# SSL
readonly BISTROSOL_DB_USER=${BISTROSOL_DB_NAME}_${APP_BRANCH}_replication
readonly BISTROSOL_DB_PASSWORD=$(get_password)

# Non-SSL
readonly BISTROSOL_DB_USER2=${BISTROSOL_DB_NAME}_${APP_BRANCH}_web
readonly BISTROSOL_DB_PASSWORD2=$(get_password)

readonly ROOT_DB_HOST=$(jq -r ".root.endpoint" ./db.json)
readonly ROOT_DB_USER=$(jq -r ".root.user" ./db.json)
readonly ROOT_DB_PASSWORD=$(jq -r ".root.password" ./db.json)
readonly ROOT_DB_PORT=$(jq -r ".root.port" ./db.json)

readonly DB_JSON_FILE=${BISTROSOL_DB_NAME}-${APP_BRANCH}.json

# Drop database
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "DROP DATABASE IF EXISTS $BISTROSOL_DB_DATABASE;"

# Create database
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE DATABASE $BISTROSOL_DB_DATABASE;"

# Create user 1
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE USER IF NOT EXISTS '$BISTROSOL_DB_USER'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD' REQUIRE SSL;"

# Update user 1 password
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "ALTER USER '$BISTROSOL_DB_USER'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD' REQUIRE SSL;"

# Grant privileges to user 1
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "GRANT ALL PRIVILEGES ON $BISTROSOL_DB_DATABASE.* TO '$BISTROSOL_DB_USER'@'%';"

# Create user 2
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "CREATE USER IF NOT EXISTS '$BISTROSOL_DB_USER2'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD2';"

# Update user 2 password
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "ALTER USER '$BISTROSOL_DB_USER2'@'%' IDENTIFIED BY '$BISTROSOL_DB_PASSWORD2';"

# Grant privileges to user 2
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "GRANT ALL PRIVILEGES ON $BISTROSOL_DB_DATABASE.* TO '$BISTROSOL_DB_USER2'@'%';"

# Flush privileges
no_pw_warning mysql -h$ROOT_DB_HOST -u$ROOT_DB_USER \
  -p$ROOT_DB_PASSWORD -P$ROOT_DB_PORT \
  -e "FLUSH PRIVILEGES;"

echo Created database $BISTROSOL_DB_DATABASE

echo Downloading database
aws s3 cp --profile $AWS_PROFILE ${S3_SQL_PATH}/${S3_SQL_FILE} $S3_SQL_FILE_DOWNLOAD_TO

# Replace database name in SQL (user `LC_ALL=C` to avoid error: illegal byte sequence)
LC_ALL=C sed -i '' -e "s/\`${BISTROSOL_DB_NAME}\`/\`${BISTROSOL_DB_NAME}_${APP_BRANCH}\`/g" $S3_SQL_FILE_DOWNLOAD_TO

# Remove DEFINER because in RDS you don't have SUPER privileges
# Error: You do not have the SUPER privilege and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
# https://www.percona.com/blog/2014/07/02/using-mysql-triggers-and-views-in-amazon-rds/#comment-10968243
LC_ALL=C sed -i '' -e "s#/\*!50017 DEFINER=\`${EXPORT_DEFINER}\`@\`%\`\*/##g" $S3_SQL_FILE_DOWNLOAD_TO
LC_ALL=C sed -i '' -e "s#DEFINER=\`${EXPORT_DEFINER}\`@\`%\` ##g" $S3_SQL_FILE_DOWNLOAD_TO 

echo Loading database. This is going to take a while, please wait.
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
