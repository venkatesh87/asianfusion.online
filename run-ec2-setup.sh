#!/bin/bash

readonly AWS_PROFILE=azhao
readonly EC2_CONFIG_FILE=ec2.json
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly KEY_PATH=$(jq -r ".keyPath" ec2.json)
readonly SSH_PORT=$(jq -r ".sshPort" ec2.json)

readonly PUBLIC_IP=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${INSTANCE_NAME}" | jq -r ".Reservations[].Instances[].PublicIpAddress"))

echo "Connecting to $PUBLIC_IP using key $KEY_PATH"

scp -i $KEY_PATH -P $SSH_PORT app.json ec2-user@${PUBLIC_IP}:/tmp/app.json
ssh ec2-user@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT < ec2-setup.sh
