#!/bin/bash

readonly DB_DEV=${DB_INSTANCE_IDENTIFIER}_dev
readonly DB_DEV_USER=${DB_INSTANCE_IDENTIFIER}_dev
readonly DB_DEV_PASSWORD=$(get_password)

readonly DB_QA=${DB_INSTANCE_IDENTIFIER}_qa
readonly DB_QA_USER=${DB_INSTANCE_IDENTIFIER}_qa
readonly DB_QA_PASSWORD=$(get_password)

readonly DB_LIVE=${DB_INSTANCE_IDENTIFIER}_live
readonly DB_LIVE_USER=${DB_INSTANCE_IDENTIFIER}_live
readonly DB_LIVE_PASSWORD=$(get_password)

echo "Db instance created"

# Dev database and user
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_DEV;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_DEV_USER'@'%' IDENTIFIED BY '$DB_DEV_PASSWORD';"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_DEV.* TO '$DB_DEV_USER'@'%';"

# Backup
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  ${DB_DEV}_backup;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON ${DB_DEV}_backup.* TO '$DB_DEV_USER'@'%';"

# QA database and user
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_QA;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_QA_USER'@'%' IDENTIFIED BY '$DB_QA_PASSWORD';"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_QA.* TO '$DB_QA_USER'@'%';"

# Backup
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  ${DB_QA}_backup;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON ${DB_QA}_backup.* TO '$DB_QA_USER'@'%';"

# Live database and user
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_LIVE;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_LIVE_USER'@'%' IDENTIFIED BY '$DB_LIVE_PASSWORD';"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_LIVE.* TO '$DB_LIVE_USER'@'%';"

# Backup
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  ${DB_LIVE}_backup;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON ${DB_LIVE}_backup.* TO '$DB_LIVE_USER'@'%';"

no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "FLUSH PRIVILEGES;"

# Generate db.json file
echo "{
  \"root\": {
    \"endpoint\": \"$DB_ENDPOINT\",
    \"user\": \"$MASTER_USERNAME\",
    \"password\": \"$MASTER_USER_PASSWORD\"
  },
  \"dev\": {
    \"endpoint\": \"$DB_ENDPOINT\",
    \"database\": \"$DB_DEV\",
    \"user\": \"$DB_DEV_USER\",
    \"password\": \"$DB_DEV_PASSWORD\"
  },
  \"qa\": {
    \"endpoint\": \"$DB_ENDPOINT\",
    \"database\": \"$DB_QA\",
    \"user\": \"$DB_QA_USER\",
    \"password\": \"$DB_QA_PASSWORD\"
  },
  \"master\": {
    \"endpoint\": \"$DB_ENDPOINT\",
    \"database\": \"$DB_LIVE\",
    \"user\": \"$DB_LIVE_USER\",
    \"password\": \"$DB_LIVE_PASSWORD\"
  }
}" > ./db.json

# cat ./db.json

# Create post-checkout
sh ./post-checkout
cp ./post-checkout .git/hooks/post-checkout
chmod u+x .git/hooks/post-checkout

# Load starting point database to dev db
sh ./load-db.sh db/wordpress.sql

# Reset wordpress
./reset-wordpress.sh 1

# Sync credential files
./sync-creds-up.sh

echo "Databases has been created. Wordpress SQL has been imported for dev database."
echo "Check db.json for access info, please save this file."
