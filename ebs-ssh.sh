#!/bin/sh

source ./variables.sh

readonly KEY_PATH=$(jq -r ".aws.${APP_BRANCH}.ec2KeyPath" ./app.json)

if [ "$KEY_PATH" != "" ]; then

  readonly PUBLIC_IP=($(aws ec2 describe-instances \
    --profile $AWS_PROFILE \
    --filters "Name=tag:Name,Values=${APP_NAME}-${APP_BRANCH}" | jq -r ".Reservations[].Instances[].PublicIpAddress"))

  echo "Connecting to $PUBLIC_IP using key $KEY_PATH"

  ssh -i $KEY_PATH ec2-user@$PUBLIC_IP

else

  echo "Key path is not specified."

fi
