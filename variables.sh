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
