#!/bin/bash

readonly AWS_PROFILE=azhao
readonly EC2_CONFIG_FILE=ec2.json
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly KEY_PATH=$(jq -r ".keyPath" ec2.json)
readonly SSH_PORT=$(jq -r ".sshPort" ec2.json)
readonly SSH_USER=$(jq -r ".sshUser" ec2.json)
readonly MYSQL_PORT=$(jq -r ".mysqlPort" ec2.json)

readonly PUBLIC_IP=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${INSTANCE_NAME}" Name=instance-state-name,Values=running | jq -r ".Reservations[].Instances[].PublicIpAddress"))

if [ "$PUBLIC_IP" == "" ]; then
  echo $INSTANCE_NAME is not found, abort.
  exit
fi;

echo "Connecting to $PUBLIC_IP using key $KEY_PATH"

# Copy up app.json to server
scp -i $KEY_PATH -P $SSH_PORT app.json ${SSH_USER}@${PUBLIC_IP}:/tmp/app.json

# Run setup script via SSH
ssh ${SSH_USER}@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT < ec2-setup.sh

# Copy down ec2-db.json from server
scp -i $KEY_PATH -P $SSH_PORT ${SSH_USER}@${PUBLIC_IP}:/tmp/ec2-db.json ec2-db.json
sed -i '' -e "s/\"endpoint\": \"\"/\"endpoint\": \"${PUBLIC_IP}\"/g" ec2-db.json
sed -i '' -e "s/\"port\": \"\"/\"port\": \"${MYSQL_PORT}\"/g" ec2-db.json

# Clean up
ssh ${SSH_USER}@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT "rm /tmp/app.json; rm /tmp/ec2-db.json"
