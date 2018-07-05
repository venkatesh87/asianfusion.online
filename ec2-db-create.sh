#!/bin/bash

source ./variables.sh
source ./functions.sh

# App config file
readonly DB_INSTANCE_IDENTIFIER=$(jq -r ".rds.instanceName" $APP_CONFIG_FILE)
readonly DB_INSTANCE_IDENTIFIER_LENGTH=${#DB_INSTANCE_IDENTIFIER}
readonly RDS_ENDPOINT=$(jq -r ".root.endpoint" ec2-db.json) 
readonly MASTER_USERNAME=$(jq -r ".root.user" ec2-db.json) 
readonly MASTER_USER_PASSWORD=$(jq -r ".root.password" ec2-db.json) 

if [[ "$DB_INSTANCE_IDENTIFIER_LENGTH" -gt 11 ]]; then
  echo "Please make RDS name less than 11 characters"
  exit
fi

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

source ./rds-create.sh
