#!/bin/bash

source ./variables.sh

BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  BRANCH=$1
fi

readonly DB_BACKUP_S3_BUCKET=$(jq -r ".aws.dbBackupS3Bucket" ./app.json)
readonly DATABASE=$(jq -r ".${BRANCH}.database" ./db.json)
readonly DATE=`date '+%Y-%m-%d-%H-%M-%S'`
readonly SQL_FILE=${DATABASE}.sql
readonly S3_SQL_FILE=${DATABASE}_${DATE}.sql

sh ./dump-db.sh $BRANCH

aws s3 cp --profile $AWS_PROFILE $SQL_FILE s3://$DB_BACKUP_S3_BUCKET/$APP_NAME/${S3_SQL_FILE}

echo "Successfully uploaded $S3_SQL_FILE"
