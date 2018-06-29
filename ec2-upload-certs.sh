#!/bin/bash

source ./variables.sh
source ./functions.sh

if [[ $# -eq 0 ]] ; then
  echo Enter a domain name
  exit
fi

readonly DOMAIN_NAME=$1

readonly EC2_CONFIG_FILE=ec2.json
readonly INSTANCE_NAME=$(jq -r ".instanceName" $EC2_CONFIG_FILE)
readonly KEY_PATH=$(jq -r ".keyPath" $EC2_CONFIG_FILE)
readonly SSH_PORT=$(jq -r ".sshPort" $EC2_CONFIG_FILE)
readonly SSH_USER=$(jq -r ".sshUser" $EC2_CONFIG_FILE)
readonly CERT_S3_BUCKET=$(jq -r ".certS3Bucket" $EC2_CONFIG_FILE)
readonly CERT_DIR=/etc/httpd/certs/${DOMAIN_NAME}
readonly TMP_CERT_DIR=${TMP}/${DOMAIN_NAME}-certs

# Download certs from S3
aws s3 cp --profile $AWS_PROFILE s3://$CERT_S3_BUCKET/${DOMAIN_NAME} $TMP_CERT_DIR --recursive

if [ ! -f ${TMP_CERT_DIR}/cert.pem ]; then
  echo Cert file not found, make sure you enter domain name correctly.
  rm -rf $TMP_CERT_DIR 
  exit
fi

readonly PUBLIC_IP=($(aws ec2 describe-instances \
  --profile $AWS_PROFILE \
  --filters "Name=tag:Name,Values=${INSTANCE_NAME}" Name=instance-state-name,Values=running | jq -r ".Reservations[].Instances[].PublicIpAddress"))

if [ "$PUBLIC_IP" == "" ]; then
  echo $INSTANCE_NAME is not found, abort.
  end
fi;

# Send certs to server
rsync -ah -e "ssh -i $KEY_PATH" $TMP_CERT_DIR/ ${SSH_USER}@${PUBLIC_IP}:${TMP_CERT_DIR}

ec2_ssh_run_cmd "sudo mkdir -p ${CERT_DIR};sudo cp ${TMP_CERT_DIR}/* ${CERT_DIR}/;rm -rf ${TMP_CERT_DIR};sudo chown -R root:root ${CERT_DIR}"

rm -rf $TMP_CERT_DIR

echo Uploaded SSL certs for $DOMAIN_NAME
