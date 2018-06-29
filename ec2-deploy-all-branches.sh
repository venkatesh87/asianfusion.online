#!/bin/bash

for BRANCH in `git branch --list|sed 's/\*//g'`;
  do
    git checkout $BRANCH
    sh ./ec2.sh deploy
  done

git checkout dev
