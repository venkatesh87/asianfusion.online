#!/bin/bash

source ./variables.sh
source ./functions.sh

#
# Begin functions
#

begin() {
  # http://patorjk.com/software/taag/#p=display&f=Big&t=AWS%20DEPLOY
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "
      __          _______   _____  ______ _____  _      ______     __
     /\ \        / / ____| |  __ \|  ____|  __ \| |    / __ \ \   / /
    /  \ \  /\  / / (___   | |  | | |__  | |__) | |   | |  | \ \_/ /
   / /\ \ \/  \/ / \___ \  | |  | |  __| |  ___/| |   | |  | |\   /
  / ____ \  /\  /  ____) | | |__| | |____| |    | |___| |__| | | |
 /_/    \_\/  \/  |_____/  |_____/|______|_|    |______\____/  |_|
                                                               v 0.1
  "
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

function create_environment() {
  readonly ENV_TO_CREATE=$1

  # Create new Application version
  no_output aws elasticbeanstalk create-application-version \
    --profile $AWS_PROFILE \
    --application-name $APP_NAME \
    --version-label $APP_FILE_VERSIONED --description $ENV_TO_CREATE \
    --source-bundle S3Bucket="$APP_S3_BUCKET",S3Key="$APP_S3_BUCKET_FILE"

  # https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html
  # Create new environment
  no_output aws elasticbeanstalk create-environment \
    --profile $AWS_PROFILE \
    --cname-prefix $ENV_TO_CREATE \
    --application-name $APP_NAME --version-label $APP_FILE_VERSIONED \
    --environment-name $ENV_TO_CREATE --solution-stack-name "$STACK" \
    --tags $ENVIRONMENT_TAGS \
    --option-settings "[
            {
                \"Namespace\": \"aws:autoscaling:launchconfiguration\",
                \"OptionName\": \"InstanceType\",
                \"Value\": \"${INSTANCE_TYPE}\"
            },
            {
                \"Namespace\": \"aws:autoscaling:launchconfiguration\",
                \"OptionName\": \"SecurityGroups\",
                \"Value\": \"${EC2_SECURITY_GROUPS}\"
            },
            {
                \"Namespace\": \"aws:elb:loadbalancer\",
                \"OptionName\": \"SecurityGroups\",
                \"Value\": \"${ELB_SECURITY_GROUPS}\"
            },
            {
              \"Namespace\": \"aws:autoscaling:launchconfiguration\",
              \"OptionName\": \"IamInstanceProfile\",
              \"Value\": \"${IAM_INSTANCE_PROFILE}\"
            },
            {
                \"Namespace\": \"aws:autoscaling:launchconfiguration\",
                \"OptionName\": \"EC2KeyName\",
                \"Value\": \"${EC2_KEY_NAME}\"
            }
        ]"
}

function update_environment() {
  readonly ENV_TO_UPDATE=$1

  no_output aws elasticbeanstalk create-application-version \
    --profile $AWS_PROFILE \
    --application-name $APP_NAME \
    --version-label $APP_FILE_VERSIONED --description $ENV_TO_UPDATE \
    --source-bundle S3Bucket="$APP_S3_BUCKET",S3Key="$APP_S3_BUCKET_FILE"

  ENV_ID=($(aws elasticbeanstalk describe-environments \
    --profile $AWS_PROFILE \
    --environment-names $ENV_TO_UPDATE | jq -r '.Environments[].EnvironmentId'))

  no_output no_output aws elasticbeanstalk update-environment \
    --profile $AWS_PROFILE \
    --environment-id "$ENV_ID" \
    --version-label "$APP_FILE_VERSIONED"
}

#
# End functions
#


begin

# Usage
if [ "${1}" != "deploy" ] && [ "${1}" != "terminate" ]; then
  echo "Usage: ./aws.sh deploy | terminate | terminate app"
  end
fi

source ./install-check.sh

########################
# Start configurations #
########################

# Application file name
readonly APP_FILE=${APP_NAME}-${APP_BRANCH}
# Environment name (AWS Elastic Beanstalk CNAME)
readonly ENV_NAME=${APP_FILE}
# Use timestamp as unique build number
readonly BUILD_NUMBER=$(date '+%Y%m%d-%H%M%S')
# Unique file name used for versioning
readonly APP_FILE_VERSIONED=${APP_FILE}-${BUILD_NUMBER}
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
# Application S3 bucket
readonly APP_S3_BUCKET=$(jq -r ".aws.appS3Bucket" $APP_CONFIG_FILE)
# Application S3 directory
readonly APP_S3_BUCKET_PATH=${APP_NAME}/${APP_BRANCH}
# Application S3 file name
readonly APP_S3_BUCKET_FILE=${APP_S3_BUCKET_PATH}/${APP_FILE_VERSIONED}.zip
# Delete application files on S3?
readonly APP_S3_DELETE=$(jq -r ".aws.appS3Delete" $APP_CONFIG_FILE)
# Delete application file "n" days old on S3
readonly APP_S3_DELETE_DAYS_OLD=$(jq -r ".aws.appS3DeleteDaysOld" $APP_CONFIG_FILE)
# SSL certificate ID
readonly SSL_CERTIFICATE_ID=$(jq -r ".aws.sslCertificateId" $APP_CONFIG_FILE)
# Basic auth enabled?
readonly BASIC_AUTH_ENABLED=$(jq -r ".basicAuth.${APP_BRANCH}.enabled" $APP_CONFIG_FILE)
# Basic auth user
readonly BASIC_AUTH_USER=$(jq -r ".basicAuth.${APP_BRANCH}.user" $APP_CONFIG_FILE)
# Basic auth password
readonly BASIC_AUTH_PASSWORD=$(jq -r ".basicAuth.${APP_BRANCH}.password" $APP_CONFIG_FILE)
# PHP MEMORY LIMIT
readonly PHP_MEMORY_LIMIT=$(jq -r ".php.${APP_BRANCH}.memoryLimit" $APP_CONFIG_FILE)
# PHP OUTPUT COMPRESSION
readonly PHP_OUTPUT_COMPRESSION=$(jq -r ".php.${APP_BRANCH}.outputCompression" $APP_CONFIG_FILE)
# PHP ALLOW URL FOPEN
readonly PHP_ALLOW_URL_FOPEN=$(jq -r ".php.${APP_BRANCH}.allowUrlFopen" $APP_CONFIG_FILE)
# PHP DISPLAY ERRORS
readonly PHP_DISPLAY_ERRORS=$(jq -r ".php.${APP_BRANCH}.displayErrors" $APP_CONFIG_FILE)
# PHP MAX EXECUTION TIME
readonly PHP_MAX_EXECUTION_TIME=$(jq -r ".php.${APP_BRANCH}.maxExecutionTime" $APP_CONFIG_FILE)
# PHP UPLOAD MAX FILE SIZE
readonly PHP_UPLOAD_MAX_FILESIZE=$(jq -r ".php.${APP_BRANCH}.uploadMaxFilesize" $APP_CONFIG_FILE)
# PHP POST MAX SIZE
readonly PHP_POST_MAX_SIZE=$(jq -r ".php.${APP_BRANCH}.postMaxSize" $APP_CONFIG_FILE)

######################
# End configurations #
######################

# Whether or not anything has been updated
UPDATED=0

# Check if database exists
if [ -f "$DB_CONFIG_FILE" ]; then

  readonly CURRENT_DB=`no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "SHOW DATABASES" | grep "^$DB_DATABASE$"`
  if [ "$CURRENT_DB" != "$DB_DATABASE" ]; then
    echo Database $DB_DATABASE does not exist
    exit
  else
    echo Database connected: $CURRENT_DB
  fi

else

  echo Database is missing
  exit

fi

# Check if app exists
readonly APP_EXISTS=($(aws elasticbeanstalk describe-application-versions \
  --profile $AWS_PROFILE \
  --application-name $APP_NAME | jq -r '.ApplicationVersions[].ApplicationName'))

# Check if environment available
readonly ENV_AVAILABLE=($(aws elasticbeanstalk check-dns-availability \
  --profile $AWS_PROFILE \
  --cname-prefix $ENV_NAME | jq -r '.Available'))

# Check environment health
readonly ENV_HEALTH=($(aws elasticbeanstalk describe-environments \
  --profile $AWS_PROFILE \
  --environment-names $ENV_NAME | jq -r '.Environments[].Health'))

# Terminate
if [ "${1}" == "terminate" ]; then
  if [ "$APP_EXISTS" == "" ]; then
    echo Application does not exist
    end
  fi

  # Terminate application
  if [ "${2}" == "app" ]; then
   
    echo Application and all its running environments are terminating...
    no_output aws elasticbeanstalk delete-application \
      --profile $AWS_PROFILE \
      --application-name $APP_NAME \
      --terminate-env-by-force
    end

  elif [ "$ENV_AVAILABLE" == "false" ]; then
    
    # Terminate environment
    if [ "$ENV_HEALTH" == "Green" ]; then
    
      echo Environment is terminating...
      no_output aws elasticbeanstalk terminate-environment \
        --profile $AWS_PROFILE \
        --environment-name $ENV_NAME
      end
    else
      echo Environment is not ready, try again later
      end
    fi
  else
    echo Environment not found
    end
  fi
fi

# Start building web content here
echo Starting...please wait

# Remove previous build
rm -f ${TMP}/$APP_FILE.zip

# Make sure wp-config.php is up to date                                         
sh ./post-checkout 1

# Go into public web directory
cd ./${PUBLIC_WEB_DIR}

# Make .ebextensions config file
mkdir -p ./.ebextensions
readonly EBEXTENSIONS_DIR=./.ebextensions
cp ../ebextensions.sample.config ${EBEXTENSIONS_DIR}/default.config

# Search and replace in .ebextensions/default.config

# Basic auth
if [ "$BASIC_AUTH_ENABLED" -eq 1 ] && [ "$BASIC_AUTH_USER" != "" ] && [ "$BASIC_AUTH_PASSWORD" != "" ]; then
  # Search, replace and uncomment these lines
  readonly HTPASSWD=$(htpasswd -nb $BASIC_AUTH_USER $BASIC_AUTH_PASSWORD)
  # Use '|' as delimiter to avoid conflict with '/' in the password
  sed -i '' -e "s|#user:password|${HTPASSWD}|g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#AuthType Basic/AuthType Basic/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#AuthName \"My Protected Area\"/AuthName \"${APP_NAME} ${APP_BRANCH}\"/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#AuthUserFile \/etc\/httpd\/\.htpasswd/AuthUserFile \/etc\/httpd\/\.htpasswd/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#Require valid-user/Require valid-user/g" ${EBEXTENSIONS_DIR}/default.config
else
  sed -i '' -e "s/#Require all granted/Require all granted/g" ${EBEXTENSIONS_DIR}/default.config
fi

# SSL certificate ID
if [ "$SSL_CERTIFICATE_ID" == "" ]; then
  # Disable SSL
  sed -i '' -e "s/aws:elb:listener:443:/#aws:elb:listener:443:/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/SSLCertificateId:/#SSLCertificateId:/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/ListenerProtocol: HTTPS/#ListenerProtocol: HTTPS/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/InstancePort: 80/#InstancePort: 80/g" ${EBEXTENSIONS_DIR}/default.config
  # Comment out SSL redirect
  sed -i '' -e "s/RewriteRule ^(.*)$ https:\/\/%{HTTP_HOST}%{REQUEST_URI} [R=301,L]/#RewriteRule ^(.*)$ https:\/\/%{HTTP_HOST}%{REQUEST_URI} [R=301,L]/" ${EBEXTENSIONS_DIR}/default.config
else
  # Use '#' as delimiter to avoid conflict with '/' in the SSL ID
  sed -i '' -e "s#SSLCertificateId:#SSLCertificateId: ${SSL_CERTIFICATE_ID}#g" ${EBEXTENSIONS_DIR}/default.config
fi

# PHP SETTINGS
sed -i '' -e "s/memory_limit = .*/memory_limit = $PHP_MEMORY_LIMIT/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/zlib.output_compression = .*/zlib.output_compression = $PHP_OUTPUT_COMPRESSION/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/allow_url_fopen = .*/allow_url_fopen = $PHP_ALLOW_URL_FOPEN/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/display_errors = .*/display_errors = $PHP_DISPLAY_ERRORS/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/max_execution_time = .*/max_execution_time = $PHP_MAX_EXECUTION_TIME/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/upload_max_filesize = .*/upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/post_max_size = .*/post_max_size = $PHP_POST_MAX_SIZE/g" ${EBEXTENSIONS_DIR}/default.config

# Database settings
sed -i '' -e "s/{DB_HOST}/$DB_HOST/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/{DB_DATABASE}/$DB_DATABASE/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/{DB_USER}/$DB_USER/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/{DB_PASSWORD}/$DB_PASSWORD/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/{DB_PORT}/$DB_PORT/g" ${EBEXTENSIONS_DIR}/default.config

# Go back
cd - >/dev/null 2>&1

# Export Wordpress as .zip to temporary directory
sh ./export.sh $TMP

# End building web content

# Send app to S3
echo Sending application to S3: s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_FILE}
aws s3 cp --quiet --profile $AWS_PROFILE \
  ${TMP}/${APP_FILE}.zip s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_FILE}

echo Deploying...

# App doesn't exists
if [ "$APP_EXISTS" == "" ]; then

  # Environment CNAME available
  if [ "$ENV_AVAILABLE" == "true" ]; then

    # Create NEW application and environment
    no_output aws elasticbeanstalk create-application \
      --application-name $APP_NAME \
      --profile $AWS_PROFILE \
      --description "$APP_NAME"
    create_environment $ENV_NAME

    UPDATED=1
    echo Successfully created application and environment

  else

    # Can't create
    echo Environment name $APP_NAME is not available
    # Clean up
    aws s3 --profile $AWS_PROFILE \
      rm s3://${APP_S3_BUCKET}/$APP_S3_BUCKET_FILE

  fi

else

  # App already exists

  # Environment CNAME available
  if [ "$ENV_AVAILABLE" == "true" ]; then

    # Create environment
    create_environment $ENV_NAME

    UPDATED=1
    echo Successfully created environment

  else

    # Update environment
    if [ "$ENV_HEALTH" == "Green" ]; then

      update_environment $ENV_NAME
      UPDATED=1
      echo Successfully updated environment

    else

      echo Environment is not ready, try again later
      # Clean up
      aws s3 --profile $AWS_PROFILE \
        rm s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_FILE}

    fi

  fi

fi

# Clean up old app files
if [ "$APP_S3_DELETE" -eq 1 ] && [ "$UPDATED" -eq 1 ]; then
  echo "Deleting old S3 files (${APP_S3_DELETE_DAYS_OLD} days old) at s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_PATH}"
  ./delete-s3.sh "s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_PATH}" "${APP_S3_DELETE_DAYS_OLD} days"
fi

if [ "$UPDATED" -eq 1 ]; then

  # Make sure wp-config.php is up to date, reset database credential
  sh ./post-checkout

  # Reset wordpress
  ./reset-wordpress.sh

  # Get environment URL
  ENV_URL=($(aws elasticbeanstalk describe-environments \
    --profile $AWS_PROFILE \
    --environment-names $ENV_NAME | jq -r '.Environments[].CNAME'))
  echo Latest build number is: ${BUILD_NUMBER}
  echo Environment will be ready shortly at: http://${ENV_URL}
fi

end
