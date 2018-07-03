#!/bin/bash

# Ubuntu Amazon EC2 AMI Locator: https://cloud-images.ubuntu.com/locator/ec2/

readonly AWS_PROFILE=azhao
readonly EC2_CONFIG_FILE=ec2.json
readonly IMAGE_ID=$(jq -r ".imageId" $EC2_CONFIG_FILE)
readonly SECURITY_GROUP_NAME=$(jq -r ".securityGroupName" $EC2_CONFIG_FILE)
readonly SECURITY_GROUP_DESCRIPTION=$(jq -r ".securityGroupDescription" $EC2_CONFIG_FILE)
readonly KEY_NAME=$(jq -r ".keyName" $EC2_CONFIG_FILE)
readonly SSH_PORT=$(jq -r ".sshPort" $EC2_CONFIG_FILE)
readonly SSH_ALLOWED_IPS=$(jq -r ".sshAllowedIps" $EC2_CONFIG_FILE)
readonly MYSQL_ALLOWED_IPS=$(jq -r ".mysqlAllowedIps" $EC2_CONFIG_FILE)
readonly MYSQL_PORT=$(jq -r ".mysqlPort" $EC2_CONFIG_FILE)
readonly WEB_ALLOWED_IPS=$(jq -r ".webAllowedIps" $EC2_CONFIG_FILE)
readonly INSTANCE_TYPE=$(jq -r ".instanceType" $EC2_CONFIG_FILE)
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly AVAILABILITY_ZONE=$(jq -r ".availabilityZone" $EC2_CONFIG_FILE)
readonly VOLUME_SIZE=$(jq -r ".volumeSize" $EC2_CONFIG_FILE)

readonly INSTANCE_EXISTS=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters Name=tag:Name,Values="${INSTANCE_NAME}" Name=instance-state-name,Values=running \
  --output text \
  --query 'Reservations[*].Instances[*].InstanceId'))

if [ "$INSTANCE_EXISTS" != "" ]; then
  echo $INSTANCE_NAME already exists, abort.
  exit
fi;

# Security group exists?
readonly SECURITY_GROUP_EXISTS=($(aws ec2 describe-security-groups \
  --profile $AWS_PROFILE \
  --group-names $SECURITY_GROUP_NAME | jq -r '.SecurityGroups[].GroupName'))

if [ "$SECURITY_GROUP_EXISTS" != "" ]; then
  # Delete if one exists
  aws ec2 delete-security-group \
    --profile $AWS_PROFILE \
    --group-name $SECURITY_GROUP_NAME
fi

# Create new security group
aws ec2 create-security-group \
  --profile $AWS_PROFILE \
  --group-name $SECURITY_GROUP_NAME \
  --description "${SECURITY_GROUP_DESCRIPTION}"

echo Created new security group $SECURITY_GROUP_NAME

# Configure inbound rules for port 80
for WEB_ALLOWED_IP in $WEB_ALLOWED_IPS
  do
  aws ec2 authorize-security-group-ingress \
    --profile $AWS_PROFILE \
    --group-name $SECURITY_GROUP_NAME \
    --protocol tcp \
    --port 80 \
    --cidr $WEB_ALLOWED_IP
done

# Configure inbound rules for port 443
for WEB_ALLOWED_IP in $WEB_ALLOWED_IPS
  do
  aws ec2 authorize-security-group-ingress \
    --profile $AWS_PROFILE \
    --group-name $SECURITY_GROUP_NAME \
    --protocol tcp \
    --port 443 \
    --cidr $WEB_ALLOWED_IP
done

# Configure inbound rules for MySQL port
for MYSQL_ALLOWED_IP in $MYSQL_ALLOWED_IPS
  do
  aws ec2 authorize-security-group-ingress \
    --profile $AWS_PROFILE \
    --group-name $SECURITY_GROUP_NAME \
    --protocol tcp \
    --port $MYSQL_PORT \
    --cidr $MYSQL_ALLOWED_IP
  done

# Configure inbound rules for SSH port
for SSH_ALLOWED_IP in $SSH_ALLOWED_IPS
  do
  aws ec2 authorize-security-group-ingress \
    --profile $AWS_PROFILE \
    --group-name $SECURITY_GROUP_NAME \
    --protocol tcp \
    --port $SSH_PORT \
    --cidr $SSH_ALLOWED_IP
  done

aws ec2 run-instances \
  --profile $AWS_PROFILE \
  --image-id $IMAGE_ID \
  --key-name $KEY_NAME \
  --tag-specifications ResourceType=instance,Tags=[{Key=Name,Value="${INSTANCE_NAME}}]" \
  --security-groups $SECURITY_GROUP_NAME \
  --instance-type $INSTANCE_TYPE \
  --placement AvailabilityZone=$AVAILABILITY_ZONE \
  --block-device-mappings DeviceName=/dev/xvda,Ebs={VolumeSize=${VOLUME_SIZE}} \
  --count 1

echo Created new EC2 instance $INSTANCE_NAME
