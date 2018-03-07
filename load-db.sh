#!/bin/sh

if [[ $# -eq 0 ]] ; then
  echo "Missing a SQL file parameter"
  exit
fi

ENV=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
SQL=$1

readonly HOST=$(jq -r ".${ENV}.endpoint" ./db.json)
readonly DATABASE=$(jq -r ".${ENV}.database" ./db.json)
readonly USER=$(jq -r ".${ENV}.user" ./db.json)
readonly PASSWORD=$(jq -r ".${ENV}.password" ./db.json)

mysql -h$HOST -u$USER -p$PASSWORD $DATABASE < "$SQL"
