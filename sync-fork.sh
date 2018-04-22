#!/bin/bash

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

git remote add upstream git@github.com:alanzhaonys/mywordpress.git

git fetch upstream

git merge upstream/${APP_BRANCH}
