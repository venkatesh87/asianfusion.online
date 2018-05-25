#!/bin/bash

if [[ $# -ne 3 ]] ; then
  echo "Missing parameters";
  echo "Example: ./rds-existing.sh awsdb.cnjk9sw6eqji.us-east-1.rds.amazonaws.com rootuser rootpassword"
  exit
fi

source ./variables.sh
source ./functions.sh

# App config file
readonly DB_INSTANCE_IDENTIFIER=$(jq -r ".rds.instanceName" $APP_CONFIG_FILE)
readonly DB_INSTANCE_IDENTIFIER_LENGTH=${#DB_INSTANCE_IDENTIFIER}
readonly DB_ENDPOINT=$1
readonly MASTER_USERNAME=$2
readonly MASTER_USER_PASSWORD=$3

if [[ "$DB_INSTANCE_IDENTIFIER_LENGTH" -gt 11 ]]; then
  echo "Please make RDS name less than 11 characters"
  exit
fi

if [ "$APP_BRANCH" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

source ./rds-create.sh
