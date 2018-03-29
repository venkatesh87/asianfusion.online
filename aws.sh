#!/bin/bash

#
# Begin functions
#

function begin() {
  echo
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "+                           AWS DEPLOYMENT                              +"
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

function end() {
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo
  exit
}

function create_environment() {
  readonly ENV_TO_CREATE=$1

  # Create new Application version
  aws elasticbeanstalk create-application-version \
    --profile $AWS_PROFILE \
    --application-name $APP_NAME \
    --version-label $APP_FILE_VERSIONED --description $ENV_TO_CREATE \
    --source-bundle S3Bucket="$APP_S3_BUCKET",S3Key="$APP_S3_BUCKET_FILE" \
    >/dev/null 2>&1

  # https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html
  # Create new environment
  aws elasticbeanstalk create-environment \
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
        ]" >/dev/null 2>&1
}

function update_environment() {
  readonly ENV_TO_UPDATE=$1

  aws elasticbeanstalk create-application-version \
    --profile $AWS_PROFILE \
    --application-name $APP_NAME \
    --version-label $APP_FILE_VERSIONED --description $ENV_TO_UPDATE \
    --source-bundle S3Bucket="$APP_S3_BUCKET",S3Key="$APP_S3_BUCKET_FILE" \
    >/dev/null 2>&1

  ENV_ID=($(aws elasticbeanstalk describe-environments \
    --profile $AWS_PROFILE \
    --environment-names $ENV_TO_UPDATE | jq -r '.Environments[].EnvironmentId'))

  aws elasticbeanstalk update-environment \
    --profile $AWS_PROFILE \
    --environment-id "$ENV_ID" \
    --version-label "$APP_FILE_VERSIONED" \
    >/dev/null 2>&1
}

function swap_environment() {
  readonly ENV_TO_WAIT=$1
  readonly ENV_TO_SWAP=$2

  # Wait for it to complete
  try=10
  i="0"

  while [ $i -lt $try ]; do
    echo "WAIT FOR ALTERNATE ENVIRONMENT TO BE READY, DON'T QUIT"
    # Give it a min
    sleep 30
    ((i++))

    ENV_TO_WAIT_HEALTH=($(aws elasticbeanstalk describe-environments \
      --profile $AWS_PROFILE \
      --environment-names $ENV_TO_WAIT | jq -r '.Environments[].Health'))

    if [ "$ENV_TO_WAIT_HEALTH" == "Green" ]; then
      aws elasticbeanstalk swap-environment-cnames \
        --profile $AWS_PROFILE \
        --source-environment-name $ENV_TO_SWAP \
        --destination-environment-name $ENV_TO_WAIT

      echo "SUCCESSFULLY SWAPPED ENVIRONMENTS"
      break
    fi

    if [ $i -eq $(( $try - 1 )) ]; then
      echo "UNABLE TO SWAPPED ENVIRONMENT"
    fi
  done
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

# Get platform
PLATFORM=$(uname)

# Check platform
if [ "$PLATFORM" != "Linux" ] && [ "$PLATFORM" != "Darwin" ]; then
  echo Your platform \"$PLATFORM\" is not supported
  end
fi

# Check awscli installation
if ! hash aws 2>/dev/null; then
  echo awscli is not installed
  end
fi

# Check jq installation
if ! hash jq 2>/dev/null; then
  echo jq is not installed
  end
fi

# Check gdate (macOS only)
if [ "$PLATFORM" == "Darwin" ]; then
  if ! hash gdate 2>/dev/null; then
    echo gdate is not installed
    end
  fi
fi

# Check awscli configurations
if [ ! -f ~/.aws/config ] || [ ! -f ~/.aws/credentials ]; then
  echo awscli is not configured
  end
fi

########################
# Start configurations #
########################

# App config file
readonly APP_CONFIG_FILE=./app.json
# Db config file
readonly DB_CONFIG_FILE=./db.json
# AWS application name
readonly APP_NAME=$(jq -r ".appName" $APP_CONFIG_FILE)
# App branch
readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
# AWS PROFILE
readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" $APP_CONFIG_FILE)
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
# Blue green deployment
readonly BLUE_GREEN_DEPLOYMENT=$(jq -r ".aws.blueGreenDeployment" $APP_CONFIG_FILE)
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

# Db credentials
readonly DB_HOST=$(jq -r ".${APP_BRANCH}.endpoint" $DB_CONFIG_FILE)
readonly DB_DATABASE=$(jq -r ".${APP_BRANCH}.database" $DB_CONFIG_FILE)
readonly DB_USER=$(jq -r ".${APP_BRANCH}.user" $DB_CONFIG_FILE)
readonly DB_PASSWORD=$(jq -r ".${APP_BRANCH}.password" $DB_CONFIG_FILE)

######################
# End configurations #
######################

# Whether or not anything has been updated
UPDATED=0


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
    echo "APPLICATION DOESN'T EXIST"
    end
  fi

  # Terminate application
  if [ "${2}" == "app" ]; then
    
    echo "APPLICATION AND ALL IT'S RUNNING ENVIRONMENTS ARE TERMINATING..."
    aws elasticbeanstalk delete-application \
      --profile $AWS_PROFILE \
      --application-name $APP_NAME \
      --terminate-env-by-force >/dev/null 2>&1
    end

  elif [ "$ENV_AVAILABLE" == "false" ]; then
    
    # Terminate environment
    if [ "$ENV_HEALTH" == "Green" ]; then
      
      echo "EVIRONMENT IS TERMINATING..."
      aws elasticbeanstalk terminate-environment \
        --profile $AWS_PROFILE \
        --environment-name $ENV_NAME >/dev/null 2>&1
     
      # Delete the alternate environment
      if [ "$APP_BRANCH" == "master" ] && [ "$BLUE_GREEN_DEPLOYMENT" -eq 1 ]; then
        
        readonly MASTER_ALT_ENV=${ENV_NAME}-alternate
        MASTER_ALT_ENV_AVAILABLE=($(aws elasticbeanstalk check-dns-availability \
          --profile $AWS_PROFILE \
          --cname-prefix $MASTER_ALT_ENV | jq -r '.Available'))
        MASTER_ALT_ENV_HEALTH=($(aws elasticbeanstalk describe-environments \
          --profile $AWS_PROFILE \
          --environment-names $MASTER_ALT_ENV | jq -r '.Environments[].Health'))
  
        if [ "$MASTER_ALT_ENV_AVAILABLE" == "false" ] && [ "$MASTER_ALT_ENV_HEALTH" == "Green" ]; then
          aws elasticbeanstalk terminate-environment \
            --profile $AWS_PROFILE
            --environment-name $MASTER_ALT_ENV >/dev/null 2>&1
        fi
      fi
      end
    else
      echo "ENVIRONMENT IS NOT READY, TRY AGAIN LATER"
      end
    fi
  else
    echo "ENVIRONMENT NOT FOUND"
    end
  fi
fi

#####################################################
# BEGIN - BUILD YOUR WEB CONTENT HERE               #
#####################################################

touch ./${PUBLIC_WEB_DIR}/build.txt
echo $BUILD_NUMBER >> ./${PUBLIC_WEB_DIR}/build.txt

# Remove previous build
rm -f /tmp/$APP_FILE.zip

# Zip up web content
echo ZIPPING UP WEB CONTENT IN $PUBLIC_WEB_DIR

# Make sure wp-config.php is up to date                                         
sh ./post-checkout

# Go into public web directory
cd ./${PUBLIC_WEB_DIR}

# Make .ebextensions config file
mkdir -p ./.ebextensions
readonly EBEXTENSIONS_DIR=./.ebextensions
cp ../ebextensions.default.config ${EBEXTENSIONS_DIR}/default.config

# Search and replace in .ebextensions/default.config

# Basic auth
if [ "$BASIC_AUTH_ENABLED" -eq 1 ]; then
  echo "ENABLING BASIC AUTH"
  # Search, replace and uncomment these lines
  readonly HTPASSWD=$(htpasswd -nb $BASIC_AUTH_USER $BASIC_AUTH_PASSWORD)
  sed -i '' -e "s~#user:password~${HTPASSWD}~g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#AuthType Basic/AuthType Basic/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#AuthName \"My Protected Area\"/AuthName \"${APP_NAME} ${APP_BRANCH}\"/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#AuthUserFile \/etc\/httpd\/\.htpasswd/AuthUserFile \/etc\/httpd\/\.htpasswd/g" ${EBEXTENSIONS_DIR}/default.config
  sed -i '' -e "s/#Require valid-user/Require valid-user/g" ${EBEXTENSIONS_DIR}/default.config
else
  sed -i '' -e "s/#Require all granted/Require all granted/g" ${EBEXTENSIONS_DIR}/default.config
fi

# SSL certificate ID
if [ "$SSL_CERTIFICATE_ID" == "" ]; then
  sed -i '' -e "s/SSLCertificateId:/#SSLCertificateId:/g" ${EBEXTENSIONS_DIR}/default.config
else
  sed -i '' -e "s~SSLCertificateId:~SSLCertificateId: ${SSL_CERTIFICATE_ID}~g" ${EBEXTENSIONS_DIR}/default.config
fi

# PHP SETTINGS
sed -i '' -e "s/memory_limit: 128M/memory_limit: $PHP_MEMORY_LIMIT/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/zlib.output_compression: \"Off\"/zlib.output_compression: \"$PHP_OUTPUT_COMPRESSION\"/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/allow_url_fopen: \"On\"/allow_url_fopen: \"$PHP_ALLOW_URL_FOPEN\"/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/display_errors: \"Off\"/display_errors: \"$PHP_DISPLAY_ERRORS\"/g" ${EBEXTENSIONS_DIR}/default.config
sed -i '' -e "s/max_execution_time: 60/max_execution_time: $PHP_MAX_EXECUTION_TIME/g" ${EBEXTENSIONS_DIR}/default.config

# Get a list of untracked GIT files
readonly UNTRACKED_GIT_FILES=$(git ls-files --others --exclude-standard)

# Exclude some files
zip -qr /tmp/$APP_FILE.zip . -x "*.git*" "*/\.DS_Store" $UNTRACKED_GIT_FILES

# Go back
cd - >/dev/null 2>&1

echo "BUILT APP LOCALLY ON /tmp/${APP_FILE}.zip"

# Reset wordpress
./reset-wordpress.sh $DB_HOST $DB_DATABASE $DB_USER $DB_PASSWORD 0

#####################################################
# END                                               #
#####################################################

# Send app to S3
echo "SENDING APP TO S3: s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_FILE}"
aws s3 cp --quiet --profile $AWS_PROFILE \
  /tmp/${APP_FILE}.zip s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_FILE}

echo "DEPLOYING..."

# App doesn't exists
if [ "$APP_EXISTS" == "" ]; then

  # Environment CNAME available
  if [ "$ENV_AVAILABLE" == "true" ]; then

    # Create NEW application and environment
    aws elasticbeanstalk create-application \
      --application-name $APP_NAME \
      --profile $AWS_PROFILE \
      --description "$APP_NAME" >/dev/null 2>&1
    create_environment $ENV_NAME

    UPDATED=1
    echo "SUCCESSFULLY CREATED APPLICATION AND ENVIRONMENT"

  else

    # Can't create
    echo "ENVIRONMENT NAME $APP_NAME IS NOT AVAILABLE"
    # Clean up
    aws s3 --profile $AWS_PROFILE \
      rm s3://${APP_S3_BUCKET}/$APP_S3_BUCKET_FILE >/dev/null 2>&1

  fi

else

  # App already exists

  # Environment CNAME available
  if [ "$ENV_AVAILABLE" == "true" ]; then

    # Create environment
    create_environment $ENV_NAME

    UPDATED=1
    echo "SUCCESSFULLY CREATED ENVIRONMENT"

  else

    # Update environment
    if [ "$ENV_HEALTH" == "Green" ]; then

      # Deploying to production and environment exists:
      # - We don't want to update exsting environment as it will create down time.
      # - Instead we create an alternate environment and swap CNAME when it's ready.
      # - This alternate environment will stay there for future use, don't delete.

      if [ "$APP_BRANCH" == "master" ] && [ "$BLUE_GREEN_DEPLOYMENT" -eq 1 ]; then

        echo "YOU'RE PUSHING TO PRODUCTION..."

        readonly MASTER_ALT_ENV=${ENV_NAME}-alternate
        readonly MASTER_ALT_ENV_AVAILABLE=($(aws elasticbeanstalk \
          --profile $AWS_PROFILE \
          check-dns-availability --cname-prefix $MASTER_ALT_ENV | jq -r '.Available'))

        if [ "$MASTER_ALT_ENV_AVAILABLE" == "true" ]; then

          echo "LET'S MAKE AN ALTERNATE ENVIRONMENT TO SWAP OVER TO AVOID DOWNTIME"
          # Create an alternate master environment
          create_environment $MASTER_ALT_ENV
          swap_environment $MASTER_ALT_ENV $ENV_NAME

        else

          # If alternate environment has already been used as production,
          # use the main environment for swapping
          ENV_URL=($(aws elasticbeanstalk describe-environments \
            --profile $AWS_PROFILE \
            --environment-names $ENV_NAME | jq -r '.Environments[].CNAME'))

          if [[ $ENV_URL == "${ENV_NAME}."* ]]; then
            echo "UPDATING ALTERNATE ENVIRONMENT (${MASTER_ALT_ENV})"
            update_environment $MASTER_ALT_ENV
            swap_environment $MASTER_ALT_ENV $ENV_NAME
          else
            echo "UPDATING ALTERNATE ENVIRONMENT (${ENV_NAME})"
            update_environment $ENV_NAME
            swap_environment $ENV_NAME $MASTER_ALT_ENV
          fi

        fi

      else

        # Not production, just update
        update_environment $ENV_NAME

      fi

      UPDATED=1
      echo "SUCCESSFULLY UPDATED ENVIRONMENT"

    else

      echo "ENVIRONMENT IS NOT READY, TRY AGAIN LATER"
      # Clean up
      aws s3 --profile $AWS_PROFILE \
        rm s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_FILE} >/dev/null 2>&1

    fi

  fi

fi

# Clean up old app files
if [ "$APP_S3_DELETE" -eq 1 ] && [ "$UPDATED" -eq 1 ]; then
  echo "TRY TO DELETE OLD S3 FILES(${APP_S3_DELETE_DAYS_OLD} days old) at s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_PATH}"
  ./delete-s3.sh "s3://${APP_S3_BUCKET}/${APP_S3_BUCKET_PATH}" "${APP_S3_DELETE_DAYS_OLD} days"
fi

if [ "$UPDATED" -eq 1 ]; then

  # Get environment URL
  ENV_URL=($(aws elasticbeanstalk describe-environments \
    --profile $AWS_PROFILE \
    --environment-names $ENV_NAME | jq -r '.Environments[].CNAME'))
  echo "LATEST BUILD NUMBER IS: ${BUILD_NUMBER}"
  echo "ENVIRONMENT WILL BE SHORTLY AT: http://${ENV_URL}"
fi

end
