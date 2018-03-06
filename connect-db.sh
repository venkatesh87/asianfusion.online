#!/bin/sh

ENV=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [[ $# -ne 0 ]] ; then
  ENV=$1
fi

readonly HOST=$(jq -r ".${ENV}.endpoint" ./db.json)
readonly DATABASE=$(jq -r ".${ENV}.database" ./db.json)
readonly USER=$(jq -r ".${ENV}.user" ./db.json)
readonly PASSWORD=$(jq -r ".${ENV}.password" ./db.json)

mysql -h$HOST -u$USER -p$PASSWORD -D$DATABASE
