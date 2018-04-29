#!/bin/bash

# Application config file
readonly APP_CONFIG_FILE=./app.json

# Database config file
readonly DB_CONFIG_FILE=./db.json

# Git branch
readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

# AWS profile
readonly AWS_PROFILE=$(jq -r ".aws.${APP_BRANCH}.profile" $APP_CONFIG_FILE)

# Application name
readonly APP_NAME=$(jq -r ".appName" $APP_CONFIG_FILE)

# Db credentials
readonly DB_HOST=$(jq -r ".${APP_BRANCH}.endpoint" $DB_CONFIG_FILE)
readonly DB_DATABASE=$(jq -r ".${APP_BRANCH}.database" $DB_CONFIG_FILE)
readonly DB_USER=$(jq -r ".${APP_BRANCH}.user" $DB_CONFIG_FILE)
readonly DB_PASSWORD=$(jq -r ".${APP_BRANCH}.password" $DB_CONFIG_FILE)
