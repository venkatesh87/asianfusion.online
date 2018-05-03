#!/bin/bash

source ./variables.sh

readonly CREDS_S3_BUCKET=$(jq -r ".aws.credsS3Bucket" $APP_CONFIG_FILE)

aws s3 cp --profile $AWS_PROFILE s3://$CREDS_S3_BUCKET/$APP_NAME/app.json ./
aws s3 cp --profile $AWS_PROFILE s3://$CREDS_S3_BUCKET/$APP_NAME/db.json ./

echo "Successfully updated app.json and db.json"
