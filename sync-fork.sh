#!/bin/bash

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

# Add remote repo
#git remote add upstream git@github.com:alanzhaonys/mywordpress.git
git remote add upstream git@github.com:BistroSolutions/mybistro.net.git

# Fetch from remote
git fetch upstream

# Merge with remote
git merge upstream/${APP_BRANCH} --no-edit

# Remove remote
git remote remove upstream

# Reset
git push --set-upstream origin $APP_BRANCH

echo Sync fork done
