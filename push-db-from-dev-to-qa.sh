#!/bin/sh

readonly ENV=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$ENV" != "dev" ]; then
  echo "You're not on dev branch"
  exit
fi

readonly DEV_HOST=$(jq -r ".${ENV}.endpoint" ./db.json)
readonly DEV_DATABASE=$(jq -r ".${ENV}.database" ./db.json)
readonly DEV_USER=$(jq -r ".${ENV}.user" ./db.json)
readonly DEV_PASSWORD=$(jq -r ".${ENV}.password" ./db.json)

readonly QA_HOST=$(jq -r ".${ENV}.endpoint" ./db.json)
readonly QA_DATABASE=$(jq -r ".${ENV}.database" ./db.json)
readonly QA_USER=$(jq -r ".${ENV}.user" ./db.json)
readonly QA_PASSWORD=$(jq -r ".${ENV}.password" ./db.json)

readonly SQL_FILE=/tmp/${DATABASE}-${ENV}.sql

mysqldump -h$DEV_HOST -u$DEV_USER -p$DEV_PASSWORD $DEV_DATABASE > "$SQL_FILE"

mysql -h$QA_HOST -u$QA_USER -p$QA_PASSWORD $QA_DATABASE < "$SQL_FILE"
