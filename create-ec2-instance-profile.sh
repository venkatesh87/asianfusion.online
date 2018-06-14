#!/bin/bash

source ./variables.sh

if [[ $# -eq 0 ]] ; then
  echo "Missing the profile name"
  exit
fi

NAME=$1
PROFILE_NAME=${NAME}-profile
ROLE_NAME=${NAME}-role

aws iam create-role --profile $AWS_PROFILE \
  --role-name $ROLE_NAME \
  --assume-role-policy-document file://ec2-instance-profile.json

aws iam create-instance-profile --profile $AWS_PROFILE \
  --instance-profile-name $PROFILE_NAME

aws iam add-role-to-instance-profile --profile $AWS_PROFILE \
  --role-name $ROLE_NAME \
  --instance-profile-name $PROFILE_NAME

aws iam list-instance-profiles --profile $AWS_PROFILE
