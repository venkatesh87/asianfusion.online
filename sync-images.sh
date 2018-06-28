#!/bin/bash

source ./variables.sh
source ./functions.sh

if [[ $# -eq 0 ]] ; then
  echo "Missing the origin and destination branch parameters"
  exit
fi

readonly ORIGIN_BRANCH=$1
readonly DEST_BRANCH=$2

# Wordpress upload S3 bucket settings
readonly UPLOAD_S3_BUCKET=$(jq -r ".aws.wordpressUploadS3Bucket" ./app.json)
readonly UPLOAD_S3_BUCKET_INNER_PATH=wp-content/uploads

readonly ORIGIN_PATH_FOLDER=${APP_NAME}/${ORIGIN_BRANCH}/${UPLOAD_S3_BUCKET_INNER_PATH}
readonly DEST_PATH_FOLDER=${APP_NAME}/${DEST_BRANCH}/${UPLOAD_S3_BUCKET_INNER_PATH}

readonly ORIGIN_PATH=${UPLOAD_S3_BUCKET}/${ORIGIN_PATH_FOLDER}
readonly DEST_PATH=${UPLOAD_S3_BUCKET}/${DEST_PATH_FOLDER}

readonly ORIGIN_URL=https://s3.amazonaws.com/${ORIGIN_PATH}
readonly DEST_URL=https://s3.amazonaws.com/${DEST_PATH}

readonly DEST_DB_HOST=$(jq -r ".${APP_BRANCH}.endpoint" $DB_CONFIG_FILE)
readonly DEST_DB_DATABASE=$(jq -r ".${APP_BRANCH}.database" $DB_CONFIG_FILE)
readonly DEST_DB_USER=$(jq -r ".${APP_BRANCH}.user" $DB_CONFIG_FILE)
readonly DEST_DB_PASSWORD=$(jq -r ".${APP_BRANCH}.password" $DB_CONFIG_FILE)
readonly DEST_DB_PORT=$(jq -r ".${APP_BRANCH}.port" $DB_CONFIG_FILE)

# Sync images between buckets
echo Syncing images

echo Origin path: $ORIGIN_PATH
echo Destination path: $DEST_PATH

aws s3 sync --profile $AWS_PROFILE s3://${ORIGIN_PATH} s3://${DEST_PATH}

# Replace image URLs in database
echo Replacing image URLs in database

no_pw_warning mysql -h$DEST_DB_HOST -u$DEST_DB_USER -p$DEST_DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_posts SET post_content = replace(post_content, '${ORIGIN_URL}', '${DEST_URL}');"

no_pw_warning mysql -h$DEST_DB_HOST -u$DEST_DB_USER -p$DEST_DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_postmeta SET meta_value = replace(meta_value, '${ORIGIN_URL}', '${DEST_URL}');"

no_pw_warning mysql -h$DEST_DB_HOST -u$DEST_DB_USER -p$DEST_DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_posts SET post_content = replace(post_content, '${ORIGIN_PATH_FOLDER}', '${DEST_PATH_FOLDER}');"

no_pw_warning mysql -h$DEST_DB_HOST -u$DEST_DB_USER -p$DEST_DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_postmeta SET meta_value = replace(meta_value, '${ORIGIN_PATH_FOLDER}', '${DEST_PATH_FOLDER}');"
