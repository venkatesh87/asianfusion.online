#!/bin/bash

source ./variables.sh
source ./functions.sh

#
# Begin functions
#

function begin() {
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

function ec2_ssh_run_cmd() {
  CMD=$1
  ssh ${SSH_USER}@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT "$CMD"
}

function end() {
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo
  exit
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
# Plugin directory
readonly PLUGIN_DIR=./${PUBLIC_WEB_DIR}/wp-content/plugins
# Platform stack
readonly STACK=$(jq -r ".aws.${APP_BRANCH}.stack" $APP_CONFIG_FILE)
# EC2 instance type
readonly INSTANCE_TYPE=$(jq -r ".aws.${APP_BRANCH}.instanceType" $APP_CONFIG_FILE)
# EC2 security group
readonly EC2_SECURITY_GROUPS=$(jq -r ".aws.${APP_BRANCH}.securityGroups" $APP_CONFIG_FILE)
# EBS load balancer security group
readonly ELB_SECURITY_GROUPS=$(jq -r ".aws.${APP_BRANCH}.elbSecurityGroups" $APP_CONFIG_FILE)
# IAM instance profile
readonly IAM_INSTANCE_PROFILE=$(jq -r ".aws.${APP_BRANCH}.iamInstanceProfile" $APP_CONFIG_FILE)
# Environment tags
readonly ENVIRONMENT_TAGS=$(jq -r ".aws.${APP_BRANCH}.tags" $APP_CONFIG_FILE)
# EC2 key pair name
readonly EC2_KEY_NAME=$(jq -r ".aws.${APP_BRANCH}.ec2KeyName" $APP_CONFIG_FILE)
# SSL certificate ID
readonly SSL_CERTIFICATE_ID=$(jq -r ".aws.sslCertificateId" $APP_CONFIG_FILE)
# Basic auth enabled?
readonly BASIC_AUTH_ENABLED=$(jq -r ".basicAuth.${APP_BRANCH}.enabled" $APP_CONFIG_FILE)
# Basic auth user
readonly BASIC_AUTH_USER=$(jq -r ".basicAuth.${APP_BRANCH}.user" $APP_CONFIG_FILE)
# Basic auth password
readonly BASIC_AUTH_PASSWORD=$(jq -r ".basicAuth.${APP_BRANCH}.password" $APP_CONFIG_FILE)
# Pro plugins to download from S3
readonly PLUGINS_DOWNLOAD_FROM_S3=$(jq -r ".wordpress.pluginsDownloadFromS3" ./app.json)

readonly EC2_CONFIG_FILE=ec2.json
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly SERVER_NAME=$(jq -r ".serverName" $EC2_CONFIG_FILE)
readonly KEY_PATH=$(jq -r ".keyPath" ec2.json)
readonly SSH_PORT=$(jq -r ".sshPort" ec2.json)
readonly SSH_USER=$(jq -r ".sshUser" ec2.json)

readonly HTML_DIR=/var/www/${ENV_NAME}
readonly HTML_DIR_WILDCARD=/var/www/${APP_NAME}-*

readonly HTTPD_CONF_FILE=/etc/httpd/conf.d/${ENV_NAME}.conf
readonly HTTPD_CONF_FILE_WILDCARD=/etc/httpd/conf.d/${APP_NAME}-*

readonly HTPASSWD_FILE=/etc/httpd/htpasswd/${ENV_NAME}.htpasswd
readonly HTPASSWD_FILE_WILDCARD=/etc/httpd/htpasswd/${APP_NAME}-*.htpasswd

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
  else
    ec2_ssh_run_cmd "rm $HTML_DIR > /dev/null 2>&1"
    echo $HTML_DIR removed

    ec2_ssh_run_cmd "sudo rm $HTTPD_CONF_FILE > /dev/null 2>&1"
    echo $HTTPD_CONF_FILE removed

    ec2_ssh_run_cmd "sudo rm $HTPASSWD_FILE > /dev/null 2>&1"
    echo $HTPASSWD_FILE removed
  fi
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

rsync -avh --delete --include-from $RSYNC_TMP_INCLUDE_FILE --exclude-from $RSYNC_TMP_EXCLUDE_FILE --prune-empty-dirs -e "ssh -i $KEY_PATH" $PUBLIC_WEB_DIR/ ${SSH_USER}@${PUBLIC_IP}:${HTML_DIR}

# Replace DB_HOST with `localhost` if database server is running on the server
ec2_ssh_run_cmd "sed -i -e \"s/define('DB_HOST', '${PUBLIC_IP}');/define('DB_HOST', 'localhost');/g\" ${HTML_DIR}/wp-config.php"

ec2_ssh_run_cmd "chown -R ${SSH_USER}:apache $HTML_DIR"

# Hardening WordPress
# https://codex.wordpress.org/Hardening_WordPress

# For directories
ec2_ssh_run_cmd "find ${HTML_DIR} -type d -exec chmod 750 {} \;"
# For files
ec2_ssh_run_cmd "find ${HTML_DIR} -type f -exec chmod 640 {} \;"

echo "Sync'd WordPress files at $HTML_DIR"

# Generate httpd.conf file and upload to server
readonly TMP_HTTPD_CONF_FILE=${TMP}/${ENV_NAME}-httpd.conf
cp httpd-sample.conf $TMP_HTTPD_CONF_FILE
THIS_DOMAIN_NAME=$DOMAIN_NAME

# Apache log levels
#emerg   Emergencies - system is unusable.
#alert   Action must be taken immediately.
#crit    Critical Conditions.
#error   Error conditions.
#warn    Warning conditions.
#notice  Normal but significant condition.
#info    Informational.
#debug   Debug-level messages
#trace1-8  Trace messages
LOG_LEVEL=warn
if [ "$APP_BRANCH" != "master" ]; then
  THIS_DOMAIN_NAME=${APP_BRANCH}.${DOMAIN_NAME}
  LOG_LEVEL=debug
fi

sed -i '' -e "s/{ENV_NAME}/${ENV_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{DOMAIN_NAME}/${THIS_DOMAIN_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{SERVER_NAME}/${SERVER_NAME}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{SSH_USER}/${SSH_USER}/g" $TMP_HTTPD_CONF_FILE
sed -i '' -e "s/{LOG_LEVEL}/${LOG_LEVEL}/g" $TMP_HTTPD_CONF_FILE

rsync -ah -e "ssh -i $KEY_PATH" $TMP_HTTPD_CONF_FILE ${SSH_USER}@${PUBLIC_IP}:${TMP_HTTPD_CONF_FILE}
ec2_ssh_run_cmd "sudo mv ${TMP_HTTPD_CONF_FILE} ${HTTPD_CONF_FILE}"
ec2_ssh_run_cmd "sudo chown root:root ${HTTPD_CONF_FILE}"
echo "Sync'd ${HTTPD_CONF_FILE} file"

# Setup basic auth
if [ "$BASIC_AUTH_ENABLED" -eq 1 ] && [ "$BASIC_AUTH_USER" != "" ] && [ "$BASIC_AUTH_PASSWORD" != "" ]; then
  readonly SETUP_HTPASSWD_CMD="echo '$(htpasswd -nb $BASIC_AUTH_USER $BASIC_AUTH_PASSWORD)' | sudo tee $HTPASSWD_FILE > /dev/null 2>&1"
  ec2_ssh_run_cmd "$SETUP_HTPASSWD_CMD"
  echo Created $HTPASSWD_FILE
fi

# Setup SSL cert
#if [ "$SSL_CERTIFICATE_ID" != "" ]; then
#fi

# Setup database backup script and CRON
readonly CRON_DIR=/usr/local/bin
readonly CRON_NAME=${ENV_NAME}-wordpress-database-backup-cron

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

rm \$SQL_FILE' | sudo tee ${CRON_DIR}/${CRON_NAME}.sh > /dev/null 2>&1"

readonly CHANGE_CRON_PERMISSION_CMD='sudo chmod 777 ${CRON_DIR}/${CRON_NAME}.sh'

readonly MIN=$((RANDOM % 60))
readonly SETUP_DB_BACKUP_CRON_CMD="echo '${MIN} * * * * root ${CRON_DIR}/${CRON_NAME}.sh' | sudo tee /etc/cron.d/${CRON_NAME} > /dev/null 2>&1"

ec2_ssh_run_cmd "$CREATE_DB_BACKUP_CRON_CMD"
ec2_ssh_run_cmd "$CHANGE_CRON_PERMISSION_CMD"
ec2_ssh_run_cmd "$SETUP_DB_BACKUP_CRON_CMD"

echo Created ${CRON_DIR}/${CRON_NAME}.sh

# Reload web server
ec2_ssh_run_cmd "sudo /etc/init.d/httpd restart"

# Make sure wp-config.php is up to date, reset database credential
sh ./post-checkout

# Reset wordpress
./reset-wordpress.sh

end
