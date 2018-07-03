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
readonly WP_PATH=wp-content/uploads

readonly ORIGIN_PATH=${APP_NAME}/${ORIGIN_BRANCH}/${WP_PATH}
readonly DEST_PATH=${APP_NAME}/${DEST_BRANCH}/${WP_PATH}

readonly ORIGIN_BUCKET=${UPLOAD_S3_BUCKET}/${ORIGIN_PATH}
readonly DEST_BUCKET=${UPLOAD_S3_BUCKET}/${DEST_PATH}

# Sync images between buckets
echo Syncing images

echo Origin path: $ORIGIN_BUCKET
echo Destination path: $DEST_BUCKET

aws s3 sync --profile $AWS_PROFILE s3://${ORIGIN_BUCKET} s3://${DEST_BUCKET}

#readonly DEST_DB_HOST=$(jq -r ".${DEST_BRANCH}.endpoint" $DB_CONFIG_FILE)
#readonly DEST_DB_DATABASE=$(jq -r ".${DEST_BRANCH}.database" $DB_CONFIG_FILE)
#readonly DEST_DB_USER=$(jq -r ".${DEST_BRANCH}.user" $DB_CONFIG_FILE)
#readonly DEST_DB_PASSWORD=$(jq -r ".${DEST_BRANCH}.password" $DB_CONFIG_FILE)
#readonly DEST_DB_PORT=$(jq -r ".${DEST_BRANCH}.port" $DB_CONFIG_FILE)

#no_pw_warning mysql -h$DEST_DB_HOST -u$DEST_DB_USER -p$DEST_DB_PASSWORD -e "UPDATE ${DEST_DB_DATABASE}.wp_posts SET post_content = replace(post_content, '${MASTER_ORIGIN_PATH}', '${DEST_PATH}');"
#no_pw_warning mysql -h$DEST_DB_HOST -u$DEST_DB_USER -p$DEST_DB_PASSWORD -e "UPDATE ${DEST_DB_DATABASE}.wp_postmeta SET meta_value = replace(meta_value, '${MASTER_ORIGIN_PATH}', '${DEST_PATH}');"
