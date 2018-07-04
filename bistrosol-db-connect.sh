#!/bin/sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly APP_NAME=$(jq -r ".appName" ./app.json)
readonly DB_CONFIG_FILE=${APP_NAME}-${APP_BRANCH}.json
readonly DB_USER=${APP_NAME}_${APP_BRANCH}_web

readonly HOST=$(jq -r ".${DB_USER}.endpoint" ${DB_CONFIG_FILE})
readonly DATABASE=$(jq -r ".${DB_USER}.database" ${DB_CONFIG_FILE})
readonly USER=$(jq -r ".${DB_USER}.user" ${DB_CONFIG_FILE})
readonly PASSWORD=$(jq -r ".${DB_USER}.password" ${DB_CONFIG_FILE})
readonly PORT=$(jq -r ".${DB_USER}.port" ${DB_CONFIG_FILE})

mysql -h$HOST -u$USER -p$PASSWORD -P$PORT -D$DATABASE

#--ssl-ca=ca.pem --ssl-cert=client-cert.pem --ssl-key=client-key.pem
