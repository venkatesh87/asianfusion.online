#!/bin/sh

readonly KEY_PATH=$(jq -r ".aws.ec2KeyPath" ./app.json)
readonly APP_NAME=$(jq -r ".appName" ./app.json)
readonly BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
readonly ENV_NAME=${APP_NAME}-${BRANCH}

readonly PUBLIC_IP=($(aws ec2 describe-instances --filters "Name=tag:Name,Values=${APP_NAME}-${BRANCH}" | jq -r ".Reservations[].Instances[].PublicIpAddress"))

echo "Connecting to $PUBLIC_IP"

ssh -i $KEY_PATH ec2-user@$PUBLIC_IP
