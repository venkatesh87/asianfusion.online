#!/bin/bash

readonly APP_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

# Add remote repo
git remote add upstream git@github.com:alanzhaonys/mywordpress.git

# Fetch from remote
git fetch upstream

# Merge with remote
git merge upstream/${APP_BRANCH}

# Remove remote
git remote remove upstream

# Reset
git push --set-upstream origin $APP_BRANCH

echo "============================================"
echo "If merge is successful, please push."
echo "If there is conflict, resolve, commit and push."
echo "And don't forget to sync other branches too."
echo "============================================"
