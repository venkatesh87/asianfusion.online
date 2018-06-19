#!/bin/bash

# Ubuntu Amazon EC2 AMI Locator: https://cloud-images.ubuntu.com/locator/ec2/

readonly AWS_PROFILE=azhao
readonly EC2_CONFIG_FILE=ec2.json
readonly IMAGE_ID=$(jq -r ".imageId" $EC2_CONFIG_FILE)
readonly SECURITY_GROUP_NAME=$(jq -r ".securityGroupName" $EC2_CONFIG_FILE)
readonly SECURITY_GROUP_DESCRIPTION=$(jq -r ".securityGroupDescription" $EC2_CONFIG_FILE)
readonly KEY_NAME=$(jq -r ".keyName" $EC2_CONFIG_FILE)
readonly INSTANCE_TYPE=$(jq -r ".instanceType" $EC2_CONFIG_FILE)
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly AVAILABILITY_ZONE=$(jq -r ".availabilityZone" $EC2_CONFIG_FILE)
readonly VOLUME_SIZE=$(jq -r ".volumeSize" $EC2_CONFIG_FILE)

aws ec2 create-security-group \
  --profile $AWS_PROFILE \
  --group-name $SECURITY_GROUP_NAME \
  --description "${SECURITY_GROUP_DESCRIPTION}"

aws ec2 authorize-security-group-ingress \
  --profile $AWS_PROFILE \
  --group-name $SECURITY_GROUP_NAME \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0

#aws ec2 describe-security-groups \
#  --profile $AWS_PROFILE \
#  --group-names $SECURITY_GROUP_NAME

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
