#!/bin/bash

function wait-for-status {
    instance=$1
    target_status=$2
    status=unknown
    while [[ "$status" != "$target_status" ]]; do
        status=($(aws rds describe-db-instances \
            --db-instance-identifier $instance | jq -r '.DBInstances[].DBInstanceStatus'))
        echo "Please wait...db is $status"
        sleep 10
    done
}

function get-endpoint {
  instance=$1
  endpoint=($(aws rds describe-db-instances \
    --db-instance-identifier $instance | jq -r '.DBInstances[].Endpoint.Address'))
  echo $endpoint
}

function get-password {
  password=$(openssl rand -base64 12)
  echo $password
}

readonly DB_INSTANCE_IDENTIFIER=mywp
readonly MASTER_USERNAME=${DB_INSTANCE_IDENTIFIER}
readonly MASTER_USER_PASSWORD=$(get-password)
readonly VPC_SECURITY_GROUP_IDS=sg-6ee73218
readonly REGION=us-east-1
readonly ALLOCATED_STORAGE=40
readonly DB_INSTANCE_CLASS=db.m1.small
readonly ENGINE=mysql
readonly ENGINE_VERSION=5.6.37

ENDPOINT=$(get-endpoint $DB_INSTANCE_IDENTIFIER)

if [ $ENDPOINT ]; then
  echo "Db instance already exists"
  exit
fi

echo "Creating new db instance: $DB_INSTANCE_IDENTIFIER"

aws rds create-db-instance \
  --db-instance-identifier $DB_INSTANCE_IDENTIFIER \
  --allocated-storage $ALLOCATED_STORAGE \
  --db-instance-class $DB_INSTANCE_CLASS \
  --engine $ENGINE \
  --engine-version $ENGINE_VERSION \
  --storage-type gp2 \
  --master-username $MASTER_USERNAME \
  --master-user-password $MASTER_USER_PASSWORD \
  --vpc-security-group-ids $VPC_SECURITY_GROUP_IDS \
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

echo "Creating databases"

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

echo "Done, check db.json for info, please save this file"

echo "[
  "root": {
    "endpoint": $ENDPOINT,
    "user": $MASTER_USERNAME,
    "password": $MASTER_USER_PASSWORD 
  },
  "dev": {
    "endpoint": $ENDPOINT,
    "database": $DB_DEV,
    "user": $DB_DEV_USER,
    "password": $DB_DEV_PASSWORD
  },
  "qa": {
    "endpoint": $ENDPOINT,
    "database": $DB_QA,
    "user": $DB_QA_USER,
    "password": $DB_QA_PASSWORD
  },
  "live": {
    "endpoint": $ENDPOINT,
    "database": $DB_LIVE,
    "user": $DB_LIVE_USER,
    "password": $DB_LIVE_PASSWORD
  }
}" > ./db.json
