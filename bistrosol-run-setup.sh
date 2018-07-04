#!/bin/bash

readonly AWS_PROFILE=azhao
readonly EC2_CONFIG_FILE=bistrosol.json
readonly EC2_DB_FILE=bistrosol-db.json
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly KEY_PATH=$(jq -r ".keyPath" $EC2_CONFIG_FILE)
readonly SSH_PORT=$(jq -r ".sshPort" $EC2_CONFIG_FILE)
readonly SSH_USER=$(jq -r ".sshUser" $EC2_CONFIG_FILE)
readonly MYSQL_PORT=$(jq -r ".mysqlPort" $EC2_CONFIG_FILE)
readonly SERVER_NAME=$(jq -r ".serverName" $EC2_CONFIG_FILE)
readonly ELASTIC_IP=$(jq -r ".elasticIp" $EC2_CONFIG_FILE)

# Remove entry from .known_hosts
ssh-keygen -R $ELASTIC_IP

readonly INSTANCE_ID=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${INSTANCE_NAME}" Name=instance-state-name,Values=running | jq -r ".Reservations[].Instances[].InstanceId"))

if [ "$INSTANCE_ID" == "" ]; then
  echo $INSTANCE_NAME is not found, abort.
  exit
fi

aws ec2 associate-address --profile $AWS_PROFILE \
  --instance-id $INSTANCE_ID --public-ip $ELASTIC_IP

readonly PUBLIC_IP=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${INSTANCE_NAME}" Name=instance-state-name,Values=running | jq -r ".Reservations[].Instances[].PublicIpAddress"))

if [ "$PUBLIC_IP" == "" ]; then
  echo $INSTANCE_NAME is not found, abort.
  exit
fi

if [ "$PUBLIC_IP" != "$ELASTIC_IP" ]; then
  echo Elastic IP assignment error
  exit
fi

echo "Connecting to $PUBLIC_IP using key $KEY_PATH"

# Copy up $EC2_CONFIG_FILE to server
scp -i $KEY_PATH -P $SSH_PORT $EC2_CONFIG_FILE ${SSH_USER}@${PUBLIC_IP}:/tmp/$EC2_CONFIG_FILE

# Run setup script via SSH
ssh ${SSH_USER}@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT < bistrosol-setup.sh

# Copy down $EC2_DB_FILE from server
scp -i $KEY_PATH -P $SSH_PORT ${SSH_USER}@${PUBLIC_IP}:/tmp/$EC2_DB_FILE $EC2_DB_FILE
sed -i '' -e "s/\"endpoint\": \"\"/\"endpoint\": \"${PUBLIC_IP}\"/g" $EC2_DB_FILE
sed -i '' -e "s/\"port\": \"\"/\"port\": \"${MYSQL_PORT}\"/g" $EC2_DB_FILE

# Copy down MySQL certs
scp -r -i $KEY_PATH -P $SSH_PORT ${SSH_USER}@${PUBLIC_IP}:/tmp/mysql-certs .

# Clean up
ssh ${SSH_USER}@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT "rm /tmp/$EC2_CONFIG_FILE; rm /tmp/$EC2_DB_FILE"

sh ./sync-creds-up.sh
