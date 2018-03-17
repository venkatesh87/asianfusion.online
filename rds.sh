#!/bin/bash

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

function get-endpoint {
  instance=$1
  endpoint=($(aws rds describe-db-instances \
    --db-instance-identifier $instance --profile $AWS_PROFILE | jq -r '.DBInstances[].Endpoint.Address'))
  echo $endpoint
}

function get-password {
  password=$(openssl rand -base64 12)
  echo $password
}

# App config file
readonly APP_CONFIG_FILE=./app.json
readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" $APP_CONFIG_FILE)
readonly DB_INSTANCE_IDENTIFIER=$(jq -r ".rds.instanceName" $APP_CONFIG_FILE)
readonly MASTER_USERNAME=$DB_INSTANCE_IDENTIFIER
readonly MASTER_USER_PASSWORD=$(get-password)
readonly REGION=$(jq -r ".rds.region" $APP_CONFIG_FILE)
readonly STORAGE_TYPE=$(jq -r ".rds.storageType" $APP_CONFIG_FILE)
readonly ALLOCATED_STORAGE=$(jq -r ".rds.allocatedStorage" $APP_CONFIG_FILE)
readonly DB_INSTANCE_CLASS=$(jq -r ".rds.instanceClass" $APP_CONFIG_FILE)
readonly ENGINE=$(jq -r ".rds.engine" $APP_CONFIG_FILE)
readonly ENGINE_VERSION=$(jq -r ".rds.engineVersion" $APP_CONFIG_FILE)

ENDPOINT=$(get-endpoint $DB_INSTANCE_IDENTIFIER)

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

if [ $ENDPOINT ]; then
  echo "Db instance already exists"
  exit
fi

echo "Creating new db instance: $DB_INSTANCE_IDENTIFIER"

aws rds create-db-instance \
  --profile $AWS_PROFILE \
  --db-instance-identifier $DB_INSTANCE_IDENTIFIER \
  --allocated-storage $ALLOCATED_STORAGE \
  --db-instance-class $DB_INSTANCE_CLASS \
  --engine $ENGINE \
  --engine-version $ENGINE_VERSION \
  --storage-type $STORAGE_TYPE \
  --master-username $MASTER_USERNAME \
  --master-user-password $MASTER_USER_PASSWORD \
  --region $REGION > /dev/null 2>&1

wait-for-status $DB_INSTANCE_IDENTIFIER available

ENDPOINT=$(get-endpoint $DB_INSTANCE_IDENTIFIER)

readonly DB_DEV=${DB_INSTANCE_IDENTIFIER}_dev
readonly DB_DEV_USER=${DB_INSTANCE_IDENTIFIER}_dev
readonly DB_DEV_PASSWORD=$(get-password)

readonly DB_QA=${DB_INSTANCE_IDENTIFIER}_qa
readonly DB_QA_USER=${DB_INSTANCE_IDENTIFIER}_qa
readonly DB_QA_PASSWORD=$(get-password)

readonly DB_LIVE=${DB_INSTANCE_IDENTIFIER}_live
readonly DB_LIVE_USER=${DB_INSTANCE_IDENTIFIER}_live
readonly DB_LIVE_PASSWORD=$(get-password)

echo "Db instance created"

# Dev database and user
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_DEV;"
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_DEV_USER'@'%' IDENTIFIED BY '$DB_DEV_PASSWORD';"
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_DEV.* TO '$DB_DEV_USER'@'%';"

# Test database and user
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_QA;"
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_QA_USER'@'%' IDENTIFIED BY '$DB_QA_PASSWORD';"
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_QA.* TO '$DB_QA_USER'@'%';"

# Live database and user
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE DATABASE  $DB_LIVE;"
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "CREATE USER '$DB_LIVE_USER'@'%' IDENTIFIED BY '$DB_LIVE_PASSWORD';"
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_LIVE.* TO '$DB_LIVE_USER'@'%';"
mysql -h$ENDPOINT -u$MASTER_USERNAME -p$MASTER_USER_PASSWORD -e "FLUSH PRIVILEGES;"

# Generate db.json file
echo "{
  \"root\": {
    \"endpoint\": \"$ENDPOINT\",
    \"user\": \"$MASTER_USERNAME\",
    \"password\": \"$MASTER_USER_PASSWORD\"
  },
  \"dev\": {
    \"endpoint\": \"$ENDPOINT\",
    \"database\": \"$DB_DEV\",
    \"user\": \"$DB_DEV_USER\",
    \"password\": \"$DB_DEV_PASSWORD\"
  },
  \"qa\": {
    \"endpoint\": \"$ENDPOINT\",
    \"database\": \"$DB_QA\",
    \"user\": \"$DB_QA_USER\",
    \"password\": \"$DB_QA_PASSWORD\"
  },
  \"master\": {
    \"endpoint\": \"$ENDPOINT\",
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

# Load starting point database
sh ./load-db.sh db/wordpress.sql

# Activate plugins
mysql -h$ENDPOINT -u$DB_DEV_USER -p$DB_DEV_PASSWORD -e "UPDATE ${DB_DEV}.wp_options SET option_value = 'a:5:{i:0;s:60:\"cf7-conditional-fields/contact-form-7-conditional-fields.php\";i:1;s:36:\"contact-form-7/wp-contact-form-7.php\";i:2;s:21:\"flamingo/flamingo.php\";i:3;s:31:\"wp-email-smtp/wp_email_smtp.php\";i:4;s:33:\"wpcf7-redirect/wpcf7-redirect.php\";}' WHERE option_name = 'active_plugins';"

echo "Database has been created."
echo "Check db.json for info, please save this file"
