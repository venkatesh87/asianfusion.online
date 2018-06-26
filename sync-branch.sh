#!/bin/bash

for BRANCH in `git branch --list|sed 's/\*//g'`;
  do
    if [ "$BRANCH" -ne "dev" ]; then
      git checkout $BRANCH
      git merge dev --no-edit
      git push
    fi 
  done

git checkout dev
