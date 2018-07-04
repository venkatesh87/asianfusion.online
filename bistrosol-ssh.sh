#!/bin/bash

readonly AWS_PROFILE=azhao
readonly EC2_CONFIG_FILE=bistrosol.json
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly KEY_PATH=$(jq -r ".keyPath" $EC2_CONFIG_FILE)
readonly SSH_PORT=$(jq -r ".sshPort" $EC2_CONFIG_FILE)
readonly SSH_USER=$(jq -r ".sshUser" $EC2_CONFIG_FILE)

readonly PUBLIC_IP=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${INSTANCE_NAME}" Name=instance-state-name,Values=running | jq -r ".Reservations[].Instances[].PublicIpAddress"))

echo "Connecting to $PUBLIC_IP using key $KEY_PATH"

ssh ${SSH_USER}@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT
