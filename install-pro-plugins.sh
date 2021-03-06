#!/bin/bash

# This scripts download paid plugins from S3 to Wordpress plugin directory,
# also making it not commitable.

source ./variables.sh

readonly PUBLIC_WEB_DIR=$(jq -r ".publicWebDir" $APP_CONFIG_FILE)
readonly PLUGIN_DIR=./${PUBLIC_WEB_DIR}/wp-content/plugins
readonly PLUGIN_S3_BUCKET=$(jq -r ".aws.pluginS3Bucket" $APP_CONFIG_FILE)
readonly PLUGINS_DOWNLOAD_FROM_S3=$(jq -r ".wordpress.pluginsDownloadFromS3" $APP_CONFIG_FILE)

if [ "$PLUGINS_DOWNLOAD_FROM_S3" != "" ]; then
  for PLUGIN_INFO in ${PLUGINS_DOWNLOAD_FROM_S3//,/ }
  do
    PLUGIN_NAME=`echo $PLUGIN_INFO | cut -d \: -f 1`
    PLUGIN_FILE=`echo $PLUGIN_INFO | cut -d \: -f 2`
    if [[ $PLUGIN_FILE == *.zip ]]; then
      echo Downloading ${PLUGIN_FILE}...
      
      # Download from S3
      aws s3 cp --profile $AWS_PROFILE s3://${PLUGIN_S3_BUCKET}/${PLUGIN_FILE} $TMP

      if [ -f ${TMP}/${PLUGIN_FILE} ]; then

        # Remove current installation of the plugin
        THIS_PLUGIN=${PLUGIN_DIR}/${PLUGIN_NAME}
        rm -rf $THIS_PLUGIN

        # Unzip now
        unzip -q ${TMP}/${PLUGIN_FILE} -d $PLUGIN_DIR

        # Create .gitignore
        echo "**/**" >> ${THIS_PLUGIN}/.gitignore

        echo Installed $THIS_PLUGIN
      
      else

        echo Plugin not downloaded

      fi
    fi
  done
fi

