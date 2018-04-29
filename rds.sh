#!/bin/bash

source ./variables.sh
source ./functions.sh

# Wait for RDS to be ready
function wait-for-status {
  instance=$1
  target_status=$2
  status=unknown
  while [[ "$status" != "$target_status" ]]; do
    status=($(aws rds describe-db-instances \
      --db-instance-identifier $instance --profile $AWS_PROFILE | jq -r '.DBInstances[].DBInstanceStatus'))
    echo "Please wait...db is $status"
    sleep 10
  done
}

# Get RDS endpoint
function get-endpoint {
  instance=$1
  endpoint=($(aws rds describe-db-instances \
    --db-instance-identifier $instance --profile $AWS_PROFILE | jq -r '.DBInstances[].Endpoint.Address'))
  echo $endpoint
}

# App config file
readonly DB_INSTANCE_IDENTIFIER=$(jq -r ".rds.instanceName" $APP_CONFIG_FILE)
readonly DB_SECURITY_GROUPS=$(jq -r ".rds.dbSecurityGroups" $APP_CONFIG_FILE)
readonly MASTER_USERNAME=$DB_INSTANCE_IDENTIFIER
readonly MASTER_USER_PASSWORD=$(get_password)
readonly REGION=$(jq -r ".rds.region" $APP_CONFIG_FILE)
readonly STORAGE_TYPE=$(jq -r ".rds.storageType" $APP_CONFIG_FILE)
readonly ALLOCATED_STORAGE=$(jq -r ".rds.allocatedStorage" $APP_CONFIG_FILE)
readonly DB_INSTANCE_CLASS=$(jq -r ".rds.instanceClass" $APP_CONFIG_FILE)
readonly ENGINE=$(jq -r ".rds.engine" $APP_CONFIG_FILE)
readonly ENGINE_VERSION=$(jq -r ".rds.engineVersion" $APP_CONFIG_FILE)

DB_ENDPOINT=$(get-endpoint $DB_INSTANCE_IDENTIFIER)

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

if [ $DB_ENDPOINT ]; then
  echo "Db instance already exists"
  exit
fi

echo "Creating new db instance: $DB_INSTANCE_IDENTIFIER"

aws rds create-db-instance \
  --profile $AWS_PROFILE \
  --db-instance-identifier $DB_INSTANCE_IDENTIFIER \
  --allocated-storage $ALLOCATED_STORAGE \
  --db-instance-class $DB_INSTANCE_CLASS \
  --db-security-groups $DB_SECURITY_GROUPS \
  --engine $ENGINE \
  --engine-version $ENGINE_VERSION \
  --storage-type $STORAGE_TYPE \
  --master-username $MASTER_USERNAME \
  --master-user-password $MASTER_USER_PASSWORD \
  --region $REGION > /dev/null 2>&1

wait-for-status $DB_INSTANCE_IDENTIFIER available

DB_ENDPOINT=$(get-endpoint $DB_INSTANCE_IDENTIFIER)

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

# QA database and user
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_QA;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_QA_USER'@'%' IDENTIFIED BY '$DB_QA_PASSWORD';"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_QA.* TO '$DB_QA_USER'@'%';"

# Live database and user
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_LIVE;"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_LIVE_USER'@'%' IDENTIFIED BY '$DB_LIVE_PASSWORD';"
no_pw_warning mysql -h$DB_ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_LIVE.* TO '$DB_LIVE_USER'@'%';"
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

echo "Databases has been created. Wordpress SQL has been imported for dev database."
echo "Check db.json for access info, please save this file."
