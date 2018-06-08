## Introduction
I created this project with the goals of easing my life around WordPress builds, deployments and maintenance. This project does have sophisticated setup and is not intented for developers who has no knowledge of [Bash programming](https://en.wikibooks.org/wiki/Bash_Shell_Scripting) and [AWS](https://aws.amazon.com/).

This repository contains:
* bash scripts to automate AWS deployment and management
* WordPress base installation and plugins

This repository has 3 branches:
* dev - used for development
* qa - used for review
* master (refer to as live) - used for production

Once fully deployed, you will be 3 enviornments running AWS ElasticBeanstalk. That's one environment per branch. Instructions are provided so that you can map the domain names these EBS environments. Here is a sneak peek! Let's say you own the domain name `mydomain.com`. You will ended up with `dev.mydomain.com`, `qa.mydomain.com` and `mydomain.com`. Cool? Using the scripts provided, lots of the tedious tasks, such as creating databases, push databases and images to production are simplifed and automated.

## Installations

### awscli

#### Ubuntu Linux
`apt-get install awcli`

#### macOS
`brew install awcli`

For installation instructions, go to http://docs.aws.amazon.com/cli/latest/userguide/installing.html.

#### Configure awscli
If this is your first time configuring awscli
```
$ aws configure
AWS Access Key ID [None]: [YOUR ACCESS KEY ID]
AWS Secret Access Key [None]: [YOUR SECRET ACCESS KEY]
Default region name [None]: us-east-1
Default output format [None]: json
```
This will create a default profile. AWS configuration will be saved to files below:

~/.aws/config 
```
[default]
region = us-east-1
output = json
```
~/.aws/credentials 
```
[default]
aws_access_key_id = [YOUR ACCESS KEY ID]
aws_secret_access_key = [YOUR SECRET ACCESS KEY]
```

If you're configuring a new profile
`aws configure --profile your-new-profile`

~/.aws/config 
```
[default]
region = us-east-1
output = json

[profile your-new-profile]
region = us-east-1
output = json
```

Re-configure AWS profile
`aws configure --profile your-profile`

For AWS name profile: https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html

For configuration instructions, go to http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html.

### jq
jq is used to parse JSON data in bash.

#### Ubuntu Linux
`apt-get install jq`

#### macOS
`brew install jq`

### gdate (macOS only)
gdate is an GNU verion of `date` for macOS

`brew install coreutils`

### mysql client

https://dev.mysql.com/downloads/shell/

### Create S3 buckets

Run `aws s3api create-bucket --bucket your-bucket --profile your-profile --region us-east-1`

You can also create buckets using S3 console.

#### Application Bucket
Bucket for application files

#### Application Credential Bucket
Bucket for app.json and db.json

#### Wordpress Upload Bucket
Bucket for WordPress uploads

#### Wordpress Plugin Bucket
Bucket for WordPress paid plugins

#### Create S3 User Wordpress Upload
Create user with S3 programtic access only, get Access key ID and Secret access key for Wordpress S3 upload plugin

Add User -> Programmtic access -> Attach existing policies directly -> AmazonS3FullAccess -> Get Access Key ID/Screct access key

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteObject",
                "s3:Put*",
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::your-upload-bucket",
                "arn:aws:s3:::your-upload-bucket/*"
            ]
        }
    ]
}
```
https://deliciousbrains.com/wp-offload-s3/doc/quick-start-guide/

### app.json

`cp app.sample.json app.json`

See app.json configuration details here
https://github.com/alanzhaonys/mywordpress/blob/dev/APP-JSON.md

## Script Usages

### ./rds.sh
Create a new database in RDS. It will create 6 databases. Let's say your application name is `awesomewp`, following database will be created:
* awesomewp_dev
* awesomewp_dev_backup*
* awesomewp_qa
* awesomewp_qa_backup*
* awesomewp_live
* awesomewp_live_backup*

*The backup database will be created after the enviornment is deployed. An `hourly` CRON will be generated to backup the database.

This script can only be run from the `dev` branch where is your logical starting point for a new project. It will configure WordPress (`./post-checkout`), load a clean WordPress database (`./load-db.sh db/wordpress.sql`), configure and activate all the base plugins (`./reset-wordpress 1`), install paid plugins (`./install-pro-plugins.sh`) and push up configuration files to S3 for storeage (`./sync-creds-up.sh`).

This process usually takes 5 to 10 minutes, so be patient. Once database is complete, you can continue with Docker setup below.

### ./rds-existing.sh

### ./docker.sh

#### ./docker.sh build
Build/rebuild all docker containers.

#### ./docker.sh remove
Remove al docker containers.

#### ./docker.sh ssh

#### ./docker.sh ssh-phpmyadmin

#### ./docker.sh ssh-mysql

### ./aws.sh

#### ./aws.sh deploy
This command deploys current branch to a Elastic Beanstalk environment.

If application doesn't exists, it creates the application. If environment doesn't exist, it creates the environment. If environment exists, it updates the environment.

#### ./aws.sh terminate
This command terminates the environment of current branch.

#### ./aws.sh terminate app
This command terminates the application and also terminates all of its environments.

### ./delete-s3.sh
*Example:* `./delete-s3.sh "s3://mys3bucket/apps/my-app/master" "7 days"`

### ./mysql-local.sh
Connect to MySQL running in Docker container. Raw MySQL data is saved in `mysql/`.

### ./mysql-remote.sh
Connect to RDS MySQL console. Database connected is the what the current branch is using.

### ./ebs-ssh
SSH into current branch's environment console.

### dump-db.sh [branch]
Dump database into a SQL file under project root directory. If `branch` parameter is not specified, current branch's database will be dumped.

### export.sh [export-path]
Export all WordPress content into a ZIP file. Database export is not included.

### open.sh
Open WordPress site in the default browser.

### open-phpmyadmin.sh
Open phpMyAdmin in the default browser.

If `connectLocalMysqlForDev` is `true`, you can login using the configured username and password.
If `connectLocalMysqlForDev` is `false`, you can login using database credentials found in `db.json`

### ./list-stacks.sh
This returns a list of most current stacks available in AWS.

### ./list-mysql.sh
This returns a list of most curent MySQL versions available in AWS.

### push-db.sh [origin-branch] [destination-branch]
Push datbase from `origin-branch` to `destination-branch`

### push-db-from-local-to-dev.sh
Shortcut for `push-db.sh local dev`

### push-db-from-dev-to-local.sh
Shortcut for `push-db.sh dev local`

### push-db-from-dev-to-qa.sh
Shortcut for `push-db.sh dev qa`

### push-db-from-dev-to-live.sh
Shortcut for `push-db.sh dev live`

### push-db-from-qa-to-live.sh
Shortcut for `push-db.sh qa live`

### sync-images.sh

### sync-images-from-dev-to-live.sh


### recaptcha
https://www.google.com/recaptcha
 * Add your domain and `localhost`
 

### Database Re-initialization

Database will be installed upon the execution of `rd.sh` or `rds-existing.sh`. You can reinstall database if you need to.

To install clean database

`./load-db.sh db/wordpress.sql`

The clean database will not have any plugins activated. The admin login for this installation is "admin/password".

To initialize application configurations

`./reset-wordpress.sh 1`

The parameter value `1` will activate all the base plugins.


SSH access
=========
Don't specify ec2 key name and path if you don't want SSH access. EBS will create the default
security group with port 22 open if ec2 key name is specified.


Domain Management
====================

Route 53 -> Create Hosted Zone(public hosted zone)
By default, a hosted zone gets 4 AWS NS(Nameserver) records

DNS
----
Go to your domain name provider, remove all existing NS records
Add the 4 AWS NS records

Create Domains
--------------
dev, qa and master all deployed

Create Record Set -> A - IPv4 address -> Alias YES -> Alias Target (Elastic Beanstalk Environments)


Certificate Manager
-----------------
Request a certificate -> Request a public certificate
  * Add domain names: www.domain.com, domain.com, *.domain.com
   * Select DNS validation
   * Confirm and request
 
    You will see "Validation not complete"
    Each domain has "Pending validation status"
   Under each domain, do Create record in Route 53
(This will create additional CNAME records in route53 for validation)
    Wait for few mins you will see "Issued" status for the domain

  Go to Details -> ARN -> Copy the string. Exampl: arn:aws:acm:us-eash-1:xxxxxxxxxxxx:certificate/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx


SES
  * Email Addresses -> Verify a New Email Address
  * Domains -> Verify a New Domain (Generate DKIM settings)
    * This will create additional CNAME records in route53 for domain verification
   * This domain will goes into "pending verification" status 
  * SMTP Settings -> Create My SMTP Credentials -> It basically creates an AWS user with SMTP permissions -> Copy SMTP username and password



AWS
======

Network & Security -> Security Groups
  * EBS create security groups automatically by default port 80, 442
  * If key pair is specified, port 22 will be open in the security group

Network & Security -> Key Pairs
  * Create new Key Pair
  * Save it and chmod it to 600

Route53
  * Create a new Zone
  * Update NS records
  * Point your domain DNS to Amazon DNS(update NS records)

Certificate Manager
  * Add domain names: www.domain.com, domain.com, *.domain.com
   * Select DNS validation. Under each domain, do Create record in Route 53.
    This will create additional CNAME records in route53 for validation

SES
  * Email Addresses -> Verify a New Email Address
  * Domains -> Verify a New Domain (Generate DKIM settings)
    * This will create additional CNAME records in route53 for domain verification
  * SMTP Settings -> Create My SMTP Credentials


AWS Profile
===========
IAM -> Users -> Security credentials -> Create access key
(~/.aws/credentials)

aws configure list
set AWS_PROFILE=default

* When switching instanceType, please terminate the EBS instance and re-deploy
  * After deployment:
    admin/whatever set in the app.json








Notes about Mysql data mount for local dev
In case connectLocalMysqlDev changed run post-checkout.sh to refresh

Push db first then image

Mysql admin connection difference between local dev and others

install-pro-plugins need to run manually

## Tested Platforms

* Ubuntu 16 LTS
* macOS High Serria

## License
MIT - See included LICENSE.md
