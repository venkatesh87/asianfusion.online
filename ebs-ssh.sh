#!/bin/sh

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" ./app.json)
readonly KEY_PATH=$(jq -r ".aws.${APP_BRANCH}.ec2KeyPath" ./app.json)
readonly APP_NAME=$(jq -r ".appName" ./app.json)

readonly PUBLIC_IP=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${APP_NAME}-${APP_BRANCH}" | jq -r ".Reservations[].Instances[].PublicIpAddress"))

echo "Connecting to $PUBLIC_IP using key $KEY_PATH"

ssh -i $KEY_PATH ec2-user@$PUBLIC_IP
