#!/bin/bash

source ./variables.sh

if [[ $# -eq 0 ]] ; then
  echo "Missing the profile name"
  exit
fi

NAME=$1
PROFILE_NAME=${NAME}-profile
ROLE_NAME=${NAME}-role

aws iam remove-role-from-instance-profile --profile $AWS_PROFILE \
  --instance-profile-name $PROFILE_NAME \
  --role-name $ROLE_NAME

aws iam delete-instance-profile --profile $AWS_PROFILE \
  --instance-profile-name $PROFILE_NAME

aws iam delete-role --profile $AWS_PROFILE \
  --role-name $ROLE_NAME

aws iam list-instance-profiles --profile $AWS_PROFILE
