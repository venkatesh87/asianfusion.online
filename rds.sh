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
    echo Please wait...db is $status
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

readonly DB_INSTANCE_IDENTIFIER_LENGTH=${#DB_INSTANCE_IDENTIFIER}

if [[ "$DB_INSTANCE_IDENTIFIER_LENGTH" -gt 11 ]]; then
  echo Please make RDS name less than 11 characters
  exit
fi

RDS_ENDPOINT=$(get-endpoint $DB_INSTANCE_IDENTIFIER)

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

if [ $RDS_ENDPOINT ]; then
  echo Db instance already exists
  exit
fi

echo Creating new db instance: $DB_INSTANCE_IDENTIFIER

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

RDS_ENDPOINT=$(get-endpoint $DB_INSTANCE_IDENTIFIER)

echo Db instance created

source ./rds-create.sh
