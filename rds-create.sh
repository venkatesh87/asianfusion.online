#!/bin/bash

# This file is included by rds.sh and rds-existing.sh

readonly RDS_PORT=3306

readonly DB_LOCAL_HOST=127.0.0.1
readonly DB_LOCAL_DATABASE=${DB_INSTANCE_IDENTIFIER}_local
readonly DB_LOCAL_USER=$(jq -r ".docker.mysql.username" $APP_CONFIG_FILE)
readonly DB_LOCAL_PASSWORD=$(jq -r ".docker.mysql.password" $APP_CONFIG_FILE)
readonly DB_LOCAL_PORT=$(jq -r ".docker.mysql.port" $APP_CONFIG_FILE)

readonly DB_DEV_DATABASE=${DB_INSTANCE_IDENTIFIER}_dev
readonly DB_DEV_USER=${DB_INSTANCE_IDENTIFIER}_dev
readonly DB_DEV_PASSWORD=$(get_password)

readonly DB_QA_DATABASE=${DB_INSTANCE_IDENTIFIER}_qa
readonly DB_QA_USER=${DB_INSTANCE_IDENTIFIER}_qa
readonly DB_QA_PASSWORD=$(get_password)

readonly DB_MASTER_DATABASE=${DB_INSTANCE_IDENTIFIER}_master
readonly DB_MASTER_USER=${DB_INSTANCE_IDENTIFIER}_master
readonly DB_MASTER_PASSWORD=$(get_password)

# Dev database and user
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "DROP DATABASE IF EXISTS $DB_DEV_DATABASE;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE DATABASE $DB_DEV_DATABASE;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE USER IF NOT EXISTS '$DB_DEV_USER'@'%' IDENTIFIED BY '$DB_DEV_PASSWORD';"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "ALTER USER '$DB_DEV_USER'@'%' IDENTIFIED BY '$DB_DEV_PASSWORD';"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "GRANT ALL PRIVILEGES ON $DB_DEV_DATABASE.* TO '$DB_DEV_USER'@'%';"

echo Created dev database $DB_DEV_DATABASE

# Dev backup
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "DROP DATABASE IF EXISTS ${DB_DEV_DATABASE}_backup;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE DATABASE ${DB_DEV_DATABASE}_backup;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "GRANT ALL PRIVILEGES ON ${DB_DEV_DATABASE}_backup.* TO '$DB_DEV_USER'@'%';"

echo Created dev database backup ${DB_DEV_DATABASE}_backup

# QA database and user
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "DROP DATABASE IF EXISTS $DB_QA_DATABASE;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE DATABASE $DB_QA_DATABASE;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE USER IF NOT EXISTS '$DB_QA_USER'@'%' IDENTIFIED BY '$DB_QA_PASSWORD';"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "ALTER USER '$DB_QA_USER'@'%' IDENTIFIED BY '$DB_QA_PASSWORD';"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "GRANT ALL PRIVILEGES ON $DB_QA_DATABASE.* TO '$DB_QA_USER'@'%';"

echo Created qa database $DB_QA_DATABASE

# QA backup
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "DROP DATABASE IF EXISTS ${DB_QA_DATABASE}_backup;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE DATABASE ${DB_QA_DATABASE}_backup;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "GRANT ALL PRIVILEGES ON ${DB_QA_DATABASE}_backup.* TO '$DB_QA_USER'@'%';"

echo Created qa database backup ${DB_QA_DATABASE}_backup

# Live database and user
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "DROP DATABASE IF EXISTS $DB_MASTER_DATABASE;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE DATABASE $DB_MASTER_DATABASE;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE USER IF NOT EXISTS '$DB_MASTER_USER'@'%' IDENTIFIED BY '$DB_MASTER_PASSWORD';"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "ALTER USER '$DB_MASTER_USER'@'%' IDENTIFIED BY '$DB_MASTER_PASSWORD';"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "GRANT ALL PRIVILEGES ON $DB_MASTER_DATABASE.* TO '$DB_MASTER_USER'@'%';"

echo Created master database $DB_MASTER_DATABASE

# Live backup
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "DROP DATABASE IF EXISTS ${DB_MASTER_DATABASE}_backup;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "CREATE DATABASE ${DB_MASTER_DATABASE}_backup;"
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "GRANT ALL PRIVILEGES ON ${DB_MASTER_DATABASE}_backup.* TO '$DB_MASTER_USER'@'%';"

echo Created master database backup ${DB_MASTER_DATABASE}_backup

# Flush privileges
no_pw_warning mysql -h$RDS_ENDPOINT -u$MASTER_USERNAME \
  -p$MASTER_USER_PASSWORD -P$RDS_PORT \
  -e "FLUSH PRIVILEGES;"

# Generate db.json file
echo "{
  \"root\": {
    \"endpoint\": \"$RDS_ENDPOINT\",
    \"user\": \"$MASTER_USERNAME\",
    \"password\": \"$MASTER_USER_PASSWORD\",
    \"port\": \"$RDS_PORT\"
  },
  \"local\": {
    \"endpoint\": \"$DB_LOCAL_HOST\",
    \"database\": \"$DB_LOCAL_DATABASE\",
    \"user\": \"$DB_LOCAL_USER\",
    \"password\": \"$DB_LOCAL_PASSWORD\",
    \"port\": \"$DB_LOCAL_PORT\"
  },
  \"dev\": {
    \"endpoint\": \"$RDS_ENDPOINT\",
    \"database\": \"$DB_DEV_DATABASE\",
    \"user\": \"$DB_DEV_USER\",
    \"password\": \"$DB_DEV_PASSWORD\",
    \"port\": \"$RDS_PORT\"
  },
  \"qa\": {
    \"endpoint\": \"$RDS_ENDPOINT\",
    \"database\": \"$DB_QA_DATABASE\",
    \"user\": \"$DB_QA_USER\",
    \"password\": \"$DB_QA_PASSWORD\",
    \"port\": \"$RDS_PORT\"
  },
  \"master\": {
    \"endpoint\": \"$RDS_ENDPOINT\",
    \"database\": \"$DB_MASTER_DATABASE\",
    \"user\": \"$DB_MASTER_USER\",
    \"password\": \"$DB_MASTER_PASSWORD\",
    \"port\": \"$RDS_PORT\"
  }
}" > ./db.json

# Create post-checkout
sh ./post-checkout
cp ./post-checkout .git/hooks/post-checkout
chmod u+x .git/hooks/post-checkout

# Load starting point databases
sh ./load-db.sh db/wordpress.sql dev
sh ./load-db.sh db/wordpress.sql qa
sh ./load-db.sh db/wordpress.sql master

# Reset wordpress
./reset-wordpress.sh 1

# Install pro plugins
./install-pro-plugins.sh

# Sync credential files
./sync-creds-up.sh

echo
echo ================================
echo Databases has been created. Clean WordPress SQL has been imported to dev database.
echo Check db.json for database access info
echo ================================
echo
