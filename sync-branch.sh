#!/bin/bash

for BRANCH in `git branch --list|sed 's/\*//g'`;
  do
    if [ "$BRANCH" != "dev" ]; then
      git checkout $BRANCH
      git merge dev --no-edit
      git push
      sh ./post-checkout
    fi 
  done

git checkout dev
