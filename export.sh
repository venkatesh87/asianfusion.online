#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo "Missing an export path parameter"
  exit
fi

readonly EXPORT_PATH=$1

# Application name
readonly APP_NAME=$(jq -r ".appName" ./app.json)

# Git branch
readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

# Application file name
readonly APP_FILE=${APP_NAME}-${APP_BRANCH}

# Public web directory
readonly PUBLIC_WEB_DIR=$(jq -r ".publicWebDir" ./app.json)

# Pro plugins to download from S3
readonly PLUGINS_DOWNLOAD_FROM_S3=$(jq -r ".wordpress.pluginsDownloadFromS3" ./app.json)

echo Building application locally at: ${EXPORT_PATH}/${APP_FILE}.zip

cd $PUBLIC_WEB_DIR

# Build exclude string pattern to exclude wp-config.php and .ebextensions/* from git untracked files
EXCLUDE_STR="wp-config.php\|ebextensions"

# Build exclude string pattern to exclude pro plugins from git untracked files
if [ "$PLUGINS_DOWNLOAD_FROM_S3" != "" ]; then
  for PLUGIN_INFO in ${PLUGINS_DOWNLOAD_FROM_S3//,/ }
  do
    PLUGIN_NAME=`echo $PLUGIN_INFO | cut -d \: -f 1`
    EXCLUDE_STR+="\|${PLUGIN_NAME}"
  done
fi

# Get a list of untracked/ignored git files with exclusions
UNTRACKED_GIT_FILES=$(git ls-files --others | grep -v $EXCLUDE_STR)

# Zip everything, excluding some files
zip -qr ${EXPORT_PATH}/${APP_FILE}.zip . -x "*.git*" "*/\.DS_Store" $UNTRACKED_GIT_FILES

# Go back
cd - >/dev/null 2>&1
