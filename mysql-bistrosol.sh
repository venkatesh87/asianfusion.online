#!/bin/sh

APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  APP_BRANCH=$1
fi

readonly DB_CONFIG_FILE=bistrosolutions-${APP_BRANCH}.json
readonly WEB_USER=bistrosolutions_${APP_BRANCH}_web

readonly HOST=$(jq -r ".${WEB_USER}.endpoint" ${DB_CONFIG_FILE})
readonly DATABASE=$(jq -r ".${WEB_USER}.database" ${DB_CONFIG_FILE})
readonly USER=$(jq -r ".${WEB_USER}.user" ${DB_CONFIG_FILE})
readonly PASSWORD=$(jq -r ".${WEB_USER}.password" ${DB_CONFIG_FILE})
readonly PORT=$(jq -r ".${WEB_USER}.port" ${DB_CONFIG_FILE})

mysql -h$HOST -u$USER -p$PASSWORD -P$PORT -D$DATABASE
