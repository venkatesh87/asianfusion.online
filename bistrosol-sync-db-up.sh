#!/bin/bash

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" ./app.json)
readonly LOCAL_SQL_PATH=../bistrosolutions-suite/db
readonly LOCAL_SQL_FILE=bistrosolutions.sql
readonly S3_SQL_PATH=s3://bistrosolutions/databases
readonly S3_SQL_FILE=bistrosolutions.sql

aws s3 cp --profile $AWS_PROFILE ${LOCAL_SQL_PATH}/${LOCAL_SQL_FILE} ${S3_SQL_PATH}/${S3_SQL_FILE}

echo Successfully uploaded ${LOCAL_SQL_PATH}/${LOCAL_SQL_FILE} to S3
