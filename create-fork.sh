#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo "Missing git location"
  exit
fi

GIT_LOCATION=$1

# Create initial branch
echo "# README" >> README.md
git init
git add README.md
git commit -m "initial commit"
git remote add origin $GIT_LOCATION
git push -u origin master

# Fork from remote repo

# Add remote repo
git remote add upstream git@github.com:alanzhaonys/mywordpress.git

# Fetch from remote
git fetch upstream

# Merge with remote
git merge upstream/master --allow-unrelated-histories

# Remove remote
git remote remove upstream

# Reset
git push --set-upstream origin master


# Create dev branch
git checkout -b dev
git push --set-upstream origin dev

# Create qa branch
git checkout -b qa
git push --set-upstream origin qa

# Checkout dev
git checkout dev
