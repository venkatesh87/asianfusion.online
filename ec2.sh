#!/bin/bash

source ./variables.sh
source ./functions.sh

#
# Begin functions
#

begin() {
  # http://patorjk.com/software/taag/#p=display&f=Big&t=EC2%20DEPLOY
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "
        ______ _____ ___    _____  ______ _____  _      ______     __
       |  ____/ ____|__ \  |  __ \|  ____|  __ \| |    / __ \ \   / /
       | |__ | |       ) | | |  | | |__  | |__) | |   | |  | \ \_/ / 
       |  __|| |      / /  | |  | |  __| |  ___/| |   | |  | |\   /  
       | |___| |____ / /_  | |__| | |____| |    | |___| |__| | | |   
       |______\_____|____| |_____/|______|_|    |______\____/  |_|   
                                                               v 0.1
  "
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

#
# End functions
#

begin

# Usage
if [ "${1}" != "deploy" ] && [ "${1}" != "terminate" ]; then
  echo "Usage: ./ec2.sh deploy | terminate | terminate app"
  end
fi

source ./install-check.sh

########################
# Start configurations #
########################

# Application domain name
readonly DOMAIN_NAME=$(jq -r ".domainName" $APP_CONFIG_FILE)
# Environment name
readonly ENV_NAME=${APP_NAME}-${APP_BRANCH}
# Public web directory
readonly PUBLIC_WEB_DIR=$(jq -r ".publicWebDir" $APP_CONFIG_FILE)
# Basic auth enabled?
readonly BASIC_AUTH_ENABLED=$(jq -r ".basicAuth.${APP_BRANCH}.enabled" $APP_CONFIG_FILE)
# Basic auth user
readonly BASIC_AUTH_USER=$(jq -r ".basicAuth.${APP_BRANCH}.user" $APP_CONFIG_FILE)
# Basic auth password
readonly BASIC_AUTH_PASSWORD=$(jq -r ".basicAuth.${APP_BRANCH}.password" $APP_CONFIG_FILE)
# Pro plugins to download from S3
readonly PLUGINS_DOWNLOAD_FROM_S3=$(jq -r ".wordpress.pluginsDownloadFromS3" ./app.json)
# EC2 Settings
readonly EC2_CONFIG_FILE=ec2.json
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly SERVER_NAME=$(jq -r ".serverName" $EC2_CONFIG_FILE)
readonly KEY_PATH=$(jq -r ".keyPath" ec2.json)
readonly SSH_PORT=$(jq -r ".sshPort" ec2.json)
readonly SSH_USER=$(jq -r ".sshUser" ec2.json)
readonly CERT_S3_BUCKET=$(jq -r ".certS3Bucket" ec2.json)
readonly CRON_DIR=/usr/local/bin
readonly DB_BACKUP_CRON_NAME=${ENV_NAME}-wordpress-database-backup-cron
# PHP settings
PHP_MEMORY_LIMIT=$(jq -r ".php.${APP_BRANCH}.memoryLimit" ./app.json)
PHP_OUTPUT_COMPRESSION=$(jq -r ".php.${APP_BRANCH}.outputCompression" ./app.json)
PHP_ALLOW_URL_FOPEN=$(jq -r ".php.${APP_BRANCH}.allowUrlFopen" ./app.json)
PHP_DISPLAY_ERRORS=$(jq -r ".php.${APP_BRANCH}.displayErrors" ./app.json)
PHP_MAX_EXECUTION_TIME=$(jq -r ".php.${APP_BRANCH}.maxExecutionTime" ./app.json)
PHP_UPLOAD_MAX_FILESIZE=$(jq -r ".php.${APP_BRANCH}.uploadMaxFilesize" ./app.json)
PHP_POST_MAX_SIZE=$(jq -r ".php.${APP_BRANCH}.postMaxSize" ./app.json)
# HTML paths
readonly HTML_DIR=/var/www/${ENV_NAME}
readonly HTML_DIR_WILDCARD=/var/www/${APP_NAME}-*
# HTTPD paths
readonly HTTPD_CONF_FILE=/etc/httpd/conf.d/${ENV_NAME}.conf
readonly HTTPD_CONF_FILE_WILDCARD=/etc/httpd/conf.d/${APP_NAME}-*.conf
# HTPASSWD paths
readonly HTPASSWD_FILE=/etc/httpd/htpasswd/${ENV_NAME}.htpasswd
readonly HTPASSWD_FILE_WILDCARD=/etc/httpd/htpasswd/${APP_NAME}-*.htpasswd
# CRON paths
readonly CRON_FILE=${CRON_DIR}/${ENV_NAME}-*.sh
readonly CRON_FILE_WILDCARD=${CRON_DIR}/${APP_NAME}-*.sh
# Certificate paths
readonly CERT_DIR=/etc/httpd/certs/${DOMAIN_NAME}
readonly CERT_DIR_WILDCARD=/etc/httpd/certs/${DOMAIN_NAME}

######################
# End configurations #
######################

readonly PUBLIC_IP=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${INSTANCE_NAME}" Name=instance-state-name,Values=running | jq -r ".Reservations[].Instances[].PublicIpAddress"))

if [ "$PUBLIC_IP" == "" ]; then
  echo $INSTANCE_NAME is not found, abort.
  end
fi;

# Check if database exists
if [ -f "$DB_CONFIG_FILE" ]; then
  echo Checking database...
  readonly CURRENT_DB=`no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "SHOW DATABASES" | grep "^$DB_DATABASE$"`
  if [ "$CURRENT_DB" != "$DB_DATABASE" ]; then
    echo Database $DB_DATABASE does not exist
    end
  else
    echo Database connected: $CURRENT_DB
  fi
else
  echo Database is missing
  end
fi

# Terminate
if [ "${1}" == "terminate" ]; then
  if [ "${2}" == "app" ]; then
    ec2_ssh_run_cmd "rm $HTML_DIR_WILDCARD > /dev/null 2>&1" 
    echo $HTML_DIR_WILDCARD removed

    ec2_ssh_run_cmd "sudo rm $HTTPD_CONF_FILE_WILDCARD > /dev/null 2>&1" 
    echo $HTTPD_CONF_FILE_WILDCARD removed

    ec2_ssh_run_cmd "sudo rm $HTPASSWD_FILE_WILDCARD > /dev/null 2>&1" 
    echo $HTPASSWD_FILE_WILDCARD removed

    ec2_ssh_run_cmd "sudo rm $CRON_FILE_WILDCARD > /dev/null 2>&1" 
    echo $CRON_FILE_WILDCARD removed

    ec2_ssh_run_cmd "rm $CERT_DIR_WILDCARD > /dev/null 2>&1" 
    echo $CERT_DIR_WILDCARD removed
  else
    ec2_ssh_run_cmd "rm $HTML_DIR > /dev/null 2>&1"
    echo $HTML_DIR removed

    ec2_ssh_run_cmd "sudo rm $HTTPD_CONF_FILE > /dev/null 2>&1"
    echo $HTTPD_CONF_FILE removed

    ec2_ssh_run_cmd "sudo rm $HTPASSWD_FILE > /dev/null 2>&1"
    echo $HTPASSWD_FILE removed

    ec2_ssh_run_cmd "sudo rm $CRON_FILE > /dev/null 2>&1"
    echo $CRON_FILE removed

    ec2_ssh_run_cmd "rm $CERT_DIR > /dev/null 2>&1"
    echo $CERT_DIR removed
  fi
  ec2_ssh_run_cmd "sudo /etc/init.d/httpd reload"
  end
fi

echo Starting...please wait

# Make sure wp-config.php is up to date                                         
sh ./post-checkout 1

# Upload WordPress files to server

cd $PUBLIC_WEB_DIR

readonly RSYNC_TMP_EXCLUDE_FILE=${TMP}/${ENV_NAME}-rsync-exclude.tmp
readonly RSYNC_TMP_INCLUDE_FILE=${TMP}/${ENV_NAME}-rsync-include.tmp

# Get a list of files to exclude
git ls-files --others > $RSYNC_TMP_EXCLUDE_FILE

# Get a list of files to force include (exceptions from the above exclude)
rm $RSYNC_TMP_INCLUDE_FILE > /dev/null 2>&1
# Specific file
echo 'wp-config.php' >> $RSYNC_TMP_INCLUDE_FILE

# Pro plugin files
if [ "$PLUGINS_DOWNLOAD_FROM_S3" != "" ]; then
  for PLUGIN_INFO in ${PLUGINS_DOWNLOAD_FROM_S3//,/ }
  do
    PLUGIN_NAME=`echo $PLUGIN_INFO | cut -d \: -f 1`
    echo "wp-content/plugins/${PLUGIN_NAME}/***" >> $RSYNC_TMP_INCLUDE_FILE
  done
fi

cd ../

# Change permission so rsync can be performed
ec2_ssh_run_cmd "sudo mkdir -p $HTML_DIR; sudo chown -R ${SSH_USER}:apache $HTML_DIR"

rsync -avh --delete --include-from $RSYNC_TMP_INCLUDE_FILE --exclude-from $RSYNC_TMP_EXCLUDE_FILE --prune-empty-dirs -e "ssh -i $KEY_PATH" $PUBLIC_WEB_DIR/ ${SSH_USER}@${PUBLIC_IP}:${HTML_DIR}

# Hardening WordPress
# https://codex.wordpress.org/Hardening_WordPress

# For directories
ec2_ssh_run_cmd "find ${HTML_DIR} -type d -exec chmod 750 {} \;"
# For files
ec2_ssh_run_cmd "find ${HTML_DIR} -type f -exec chmod 640 {} \;"

# Replace DB_HOST with `localhost` if database server is running on the server
ec2_ssh_run_cmd "sed -i -e \"s/define('DB_HOST', '${PUBLIC_IP}');/define('DB_HOST', 'localhost');/g\" ${HTML_DIR}/wp-config.php"

echo "Sync'd WordPress files at $HTML_DIR"

# Generate httpd.conf file and upload to server
readonly TMP_HTTPD_CONF_FILE=${TMP}/${ENV_NAME}-httpd.conf
cp httpd-sample.conf $TMP_HTTPD_CONF_FILE
THIS_DOMAIN_NAME=$DOMAIN_NAME
HTTPS_DOMAIN_NAME=''
THIS_SERVER_ALIAS=''

# Apache log levels
# emerg   Emergencies - system is unusable.
# alert   Action must be taken immediately.
# crit    Critical Conditions.
# error   Error conditions.
# warn    Warning conditions.
# notice  Normal but significant condition.
# info    Informational.
# debug   Debug-level messages
# trace1-8  Trace messages
LOG_LEVEL=warn
if [ "$APP_BRANCH" != "master" ]; then
  THIS_DOMAIN_NAME=${APP_BRANCH}.${DOMAIN_NAME}
  HTTPS_DOMAIN_NAME=$THIS_DOMAIN_NAME
  LOG_LEVEL=debug
else
  THIS_SERVER_ALIAS="ServerAlias www.${DOMAIN_NAME}"
  HTTPS_DOMAIN_NAME="www.${DOMAIN_NAME}"
fi

sed -i '' -e "s/{ENV_NAME}/${ENV_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{THIS_DOMAIN_NAME}/${THIS_DOMAIN_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{THIS_SERVER_ALIAS}/${THIS_SERVER_ALIAS}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{HTTPS_DOMAIN_NAME}/${HTTPS_DOMAIN_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{DOMAIN_NAME}/${DOMAIN_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{SERVER_NAME}/${SERVER_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{SSH_USER}/${SSH_USER}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{LOG_LEVEL}/${LOG_LEVEL}/g" $TMP_HTTPD_CONF_FILE

# Setup basic auth
if [ "$BASIC_AUTH_ENABLED" -eq 1 ] && [ "$BASIC_AUTH_USER" != "" ] && [ "$BASIC_AUTH_PASSWORD" != "" ]; then
  readonly SETUP_HTPASSWD_CMD="echo '$(htpasswd -nb $BASIC_AUTH_USER $BASIC_AUTH_PASSWORD)' | sudo tee $HTPASSWD_FILE > /dev/null 2>&1"
  ec2_ssh_run_cmd "$SETUP_HTPASSWD_CMD"
  echo Created $HTPASSWD_FILE
else
  # Comment out basic auth
  sed -i '' -e "s/AuthType/#AuthType/g" $TMP_HTTPD_CONF_FILE
  sed -i '' -e "s/AuthName/#AuthName/g" $TMP_HTTPD_CONF_FILE
  sed -i '' -e "s/AuthUserFile/#AuthUserFile/g" $TMP_HTTPD_CONF_FILE
  sed -i '' -e "s/Require valid-user/#Require valid-user/g" $TMP_HTTPD_CONF_FILE
fi

rsync -ah -e "ssh -i $KEY_PATH" $TMP_HTTPD_CONF_FILE ${SSH_USER}@${PUBLIC_IP}:${TMP_HTTPD_CONF_FILE}
ec2_ssh_run_cmd "sudo mv ${TMP_HTTPD_CONF_FILE} ${HTTPD_CONF_FILE};sudo chown root:root ${HTTPD_CONF_FILE}"
echo "Sync'd ${HTTPD_CONF_FILE} file"

readonly TMP_CERT_DIR=${TMP}/${DOMAIN_NAME}-certs
# Download certs from S3
aws s3 cp --profile $AWS_PROFILE s3://$CERT_S3_BUCKET/${DOMAIN_NAME} $TMP_CERT_DIR --recursive

# Send certs to server
rsync -ah -e "ssh -i $KEY_PATH" $TMP_CERT_DIR/ ${SSH_USER}@${PUBLIC_IP}:${TMP_CERT_DIR}
ec2_ssh_run_cmd "sudo mkdir -p ${CERT_DIR};sudo cp ${TMP_CERT_DIR}/* ${CERT_DIR}/;rm -rf ${TMP_CERT_DIR};sudo chown -R root:root ${CERT_DIR}"
echo "Sync'd SSL certs at $CERT_DIR"
rm -rf $TMP_CERT_DIR

# Redirect

# Setup database backup script and CRON
readonly CREATE_DB_BACKUP_CRON_CMD="echo -e '#!/bin/bash

readonly DB_HOST=localhost
readonly DB_DATABASE=${DB_DATABASE}
readonly DB_USER=${DB_USER}
readonly DB_PASSWORD=${DB_PASSWORD}
readonly DB_PORT=${DB_PORT}
readonly DB_DATABASE_BACKUP=${DB_DATABASE}_backup
readonly SQL_FILE=/tmp/${DB_DATABASE}.sql

mysqldump -h\$DB_HOST -u\$DB_USER -p\$DB_PASSWORD -P\$DB_PORT \$DB_DATABASE > \$SQL_FILE
mysql -h\$DB_HOST -u\$DB_USER -p\$DB_PASSWORD -P\$DB_PORT \$DB_DATABASE_BACKUP < \$SQL_FILE

rm \$SQL_FILE' | sudo tee ${CRON_DIR}/${DB_BACKUP_CRON_NAME}.sh > /dev/null 2>&1"

readonly CHANGE_CRON_PERMISSION_CMD="sudo chmod 777 ${CRON_DIR}/${DB_BACKUP_CRON_NAME}.sh"

readonly MIN=$((RANDOM % 60))
readonly SETUP_DB_BACKUP_CRON_CMD="echo '${MIN} * * * * root ${CRON_DIR}/${DB_BACKUP_CRON_NAME}.sh' | sudo tee /etc/cron.d/${DB_BACKUP_CRON_NAME} > /dev/null 2>&1"

ec2_ssh_run_cmd "$CREATE_DB_BACKUP_CRON_CMD;$CHANGE_CRON_PERMISSION_CMD;$SETUP_DB_BACKUP_CRON_CMD"

echo Created ${CRON_DIR}/${DB_BACKUP_CRON_NAME}.sh

# PHP settings (can append to .htaccess because it get replaced upon every deploy)
ec2_ssh_run_cmd "sudo echo '
# PHP settings
php_value memory_limit $PHP_MEMORY_LIMIT
php_flag output_compression $PHP_OUTPUT_COMPRESSION
php_flag allow_url_fopen $PHP_ALLOW_URL_FOPEN
php_flag display_errors $PHP_DISPLAY_ERRORS
php_value max_execution_time $PHP_MAX_EXECUTION_TIME
php_value upload_max_filesize $PHP_UPLOAD_MAX_FILESIZE
php_value post_max_size $PHP_POST_MAX_SIZE' >> $HTML_DIR/.htaccess"

# Revert the permission
ec2_ssh_run_cmd "sudo chown -R apache:apache $HTML_DIR"

# Reload web server
ec2_ssh_run_cmd "sudo /etc/init.d/httpd reload"

# Make sure wp-config.php is up to date, reset database credential
sh ./post-checkout

# Reset wordpress
./reset-wordpress.sh

end
