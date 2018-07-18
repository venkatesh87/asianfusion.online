#!/bin/sh

readonly DB_CONFIG_FILE=bistrosol-db.json
readonly DB_USER=root

readonly HOST=$(jq -r ".${DB_USER}.endpoint" ${DB_CONFIG_FILE})
readonly USER=$(jq -r ".${DB_USER}.user" ${DB_CONFIG_FILE})
readonly PASSWORD=$(jq -r ".${DB_USER}.password" ${DB_CONFIG_FILE})
readonly PORT=$(jq -r ".${DB_USER}.port" ${DB_CONFIG_FILE})

mysql -h$HOST -u$USER -p$PASSWORD -P$PORT
