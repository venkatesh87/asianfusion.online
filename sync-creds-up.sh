#!/bin/bash

source ./variables.sh

readonly CREDS_S3_BUCKET=$(jq -r ".aws.credsS3Bucket" $APP_CONFIG_FILE)

aws s3 cp --profile $AWS_PROFILE ./app.json s3://$CREDS_S3_BUCKET/$APP_NAME/app.json
aws s3 cp --profile $AWS_PROFILE ./db.json s3://$CREDS_S3_BUCKET/$APP_NAME/db.json
aws s3 cp --profile $AWS_PROFILE ./ec2.json s3://$CREDS_S3_BUCKET/$APP_NAME/ec2.json
aws s3 cp --profile $AWS_PROFILE ./ec2-db.json s3://$CREDS_S3_BUCKET/$APP_NAME/ec2-db.json
aws s3 cp --profile $AWS_PROFILE ./bistrosol.json s3://$CREDS_S3_BUCKET/$APP_NAME/
aws s3 cp --profile $AWS_PROFILE ./bistrosol-db.json s3://$CREDS_S3_BUCKET/$APP_NAME/
aws s3 cp --profile $AWS_PROFILE ./${APP_NAME}-*.json s3://$CREDS_S3_BUCKET/$APP_NAME/
aws s3 sync --profile $AWS_PROFILE ./mysql-certs s3://$CREDS_S3_BUCKET/$APP_NAME/mysql-certs

echo "Successfully uploaded creds"
