#!/bin/sh

aws rds describe-db-engine-versions | grep "mysql 5\."
