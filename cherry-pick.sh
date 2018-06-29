#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo "Enter a commit id (run \`git log\` to see commit history)"
  echo "Example: ./cherry-pick.sh [commit id] --skip-master"
  exit
fi

# Commmit id parameter
readonly commit=$1
# --skip-master parameter
readonly skip_master=$2
# Current branch
readonly current_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
# The branch of the original commit is made under
readonly originating_branch=dev

if [ "$current_branch" != "$originating_branch" ] ; then
  echo "Your are not in $originating_branch branch"
  exit
fi

for branch in `git branch --list|sed 's/\*//g'`;
  do
    if [ "$branch" != $originating_branch ] ; then
      
      if [ "$skip_master" == "--skip-master" ] \
        && [ "$branch" == "master" ] ; then
        continue
      fi

      git checkout $branch
      git cherry-pick -x $commit
      git push
    fi
  done

git checkout $originating_branch
