#!/bin/sh

aws elasticbeanstalk list-available-solution-stacks | jq -r '.SolutionStacks[]' | grep PHP
