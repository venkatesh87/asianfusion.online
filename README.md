# DRAFT

## Table of Content
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [AWS Setup](#aws-setup)
   - [Create S3 Buckets](#create-s3-buckets)
4. [Instructions and Script Usages](#instructions-and-script-usages)
   - [Application Configurations](#application-configurations)
   - [Database Setup](#database-setup)
   - [Docker Operations](#docker-operations)
   - [Depolyment Operations](#deployment-operations)
 5. [MISC Scripts](#misc-scripts)
 6. [Environment Migration](#environment-migration)
 7. [Maintenance](#maintenance)
 8. [Third Party Integrations](#third-party-integrations)
 9. [Domain and SSL Management](#domain-and-ssl-management)
 10. [Forking](#forking)
 11. [Tested Platforms](#tested-platforms)
 12. [Licensing](#licensing)
 

## Introduction
I created this project with the goal of easing my life around WordPress builds, deployments and maintenance. This project does have sophisticated setup initially and is not intented for developers who has no knowledge of [Bash programming](https://en.wikibooks.org/wiki/Bash_Shell_Scripting) and [AWS](https://aws.amazon.com/), and obviously you need to know [WordPress](https://wordpress.org/).

This repository contains:
* bash scripts to automate AWS deployment and management
* WordPress base installation and plugins

This repository has 3 branches:
* dev - used for development
* qa - used for review
* master (refer to as live) - used for production

Once all branches are deployed, you will have 3 enviornments running in AWS Elastic Beanstalk. That's one environment per branch. Instructions are provided in [Domain and SSL Management](#domain-and-ssl-management) so that you can map the domain names to these EBS environments. Here is a sneak peek! Let's say you own the domain name `mydomain.com`. You will ended up with `dev.mydomain.com`, `qa.mydomain.com` and `mydomain.com`. Cool? Using the scripts provided, a lot of the tedious tasks, such as creating databases, migrating databases and images to production are simplifed and automated.

There are many features you can benefit from using this project:
- Develop locally in Docker environment, push to AWS Elastic Beanstalk dev/qa/live straight LAMP environments
- When there is no internet connection, switch to local MySQL
- phpMyAdmin for quick database edits
- One command deployment to AWS, no CI tool needed
- Scripts for common tasks including loading, dumping and pushing databases, SSHing to any environment 
- Simple application and datagbase configurations
- Host WordPress upload files in AWS S3
- Secure WordPress backend login, e.g. `/hidden-login` instead of `/wp-admin`
- Basic authentication and SSL for all environments
- Clean WordPress dashboard
- Clean [Astra theme](https://wpastra.com/)
- [Elementor](https://elementor.com/) site builder
- A few base plugins:
  - [Advanced Custom Fields](https://wordpress.org/plugins/advanced-custom-fields/)
  - [Akismet Anti-spam](https://wordpress.org/plugins/akismet/)
  - [Contact Form 7](https://wordpress.org/plugins/contact-form-7/)
  - [Custom Post Type UI](https://wordpress.org/plugins/custom-post-type-ui/)
  - [Yoast SEO](https://wordpress.org/plugins/wordpress-seo/)
  - [WP Offload S3 Lite](https://wordpress.org/plugins/amazon-s3-and-cloudfront/)

## Installation

### awscli

#### Ubuntu Linux
`apt-get install awcli`

#### macOS
`brew install awcli`

For installation instructions, go to http://docs.aws.amazon.com/cli/latest/userguide/installing.html.

#### Configure awscli
**If this is your first time configuring awscli:**
```
$ aws configure
AWS Access Key ID [None]: [YOUR ACCESS KEY ID]
AWS Secret Access Key [None]: [YOUR SECRET ACCESS KEY]
Default region name [None]: us-east-1
Default output format [None]: json
```
This will create a default profile. AWS configuration will be saved to files below:

**~/.aws/config**
```
[default]
region = us-east-1
output = json
```
**~/.aws/credentials**
```
[default]
aws_access_key_id = [YOUR ACCESS KEY ID]
aws_secret_access_key = [YOUR SECRET ACCESS KEY]
```

**If you're configuring a new profile:**

`aws configure --profile your-new-profile`

**~/.aws/config**
```
[default]
region = us-east-1
output = json

[profile your-new-profile]
region = us-east-1
output = json
```

**Re-configure AWS profile**

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

## AWS Setup

### Create S3 buckets

Using command: `aws s3api create-bucket --bucket your-bucket --profile your-profile --region us-east-1`

You can also create buckets using S3 console.

#### Application Bucket
Bucket for application files. See `appS3Bucket` config in [`app.json`](#https://github.com/alanzhaonys/mywordpress/blob/dev/APP-JSON.md)

#### Application Credential Bucket
Bucket for app.json and db.json. See `credsS3Bucket` config in [`app.json`](#https://github.com/alanzhaonys/mywordpress/blob/dev/APP-JSON.md)

#### WordPress Upload Bucket
Bucket for WordPress uploads. See `wordpressUploadS3Bucket` config in [`app.json`](#https://github.com/alanzhaonys/mywordpress/blob/dev/APP-JSON.md)

#### WordPress Plugin Bucket
Bucket for WordPress paid plugins. See `pluginS3Bucket` config in [`app.json`](#https://github.com/alanzhaonys/mywordpress/blob/dev/APP-JSON.md)

#### Create S3 User for Offload S3 Plugin

Create a user with S3 programtic access only, get Access key ID and Secret access key for Wordpress S3 upload plugin.

IAM -> Users -> Add User -> Programatic access -> Attach existing policies directly -> Review -> Get Access Key ID/Screct access key

You first create an user without any permission. Go to that user, under Permissions tab -> Add inline policy -> JSON tab, copy and paste the policy below with your own bucket name -> Save.

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

More detailed instructions can be found: https://deliciousbrains.com/wp-offload-s3/doc/quick-start-guide/

## Instructions and Script Usages

### Application Configurations

`cp app.sample.json app.json`

See app.json configuration details here
https://github.com/alanzhaonys/mywordpress/blob/dev/APP-JSON.md

`app.json` is ignored by `.gitignore`

### Database Setup

#### Create New RDS Instance and Databases

`./rds.sh`

Create a new database in RDS. It will create 6 databases. Let's say your application name is `awesomewp`, following database will be created:
- awesomewp_dev
- awesomewp_dev_backup*
- awesomewp_qa
- awesomewp_qa_backup*
- awesomewp_live
- awesomewp_live_backup*

*The backup database will be created after the enviornment is deployed. An `hourly` CRON will be generated to backup the database.*

This script can only be run from the `dev` branch where is your logical starting point for a new project. It will configure WordPress (`./post-checkout`), load a clean WordPress database (`./load-db.sh db/wordpress.sql`), configure and activate all the base plugins (`./reset-wordpress 1`), install paid plugins (`./install-pro-plugins.sh`) and push up configuration files to S3 for storeage (`./sync-creds-up.sh`).

This process usually takes 5 to 10 minutes, so be patient. Once database is complete, you can continue with Docker setup below.

A `db.json` will be created in project root directory. This file is ignored by `.gitignore`.

#### Create Databases on Existing RDS Instance

Similar to above, but without creating a new RDS instance. It creates databases on an existing RDS instance.

`./rds-existing.sh [database-endpoint] [root-username] [root-password]`

### Docker Operations

**`./docker.sh build`**

Build/rebuild all docker containers.

**`./docker.sh remove`**

Remove al docker containers.

**`./docker.sh ssh`**

SSH into WordPress Docker container

**`./docker.sh ssh-phpmyadmin`**

SSH into phpMyAdmin Docker container

**`./docker.sh ssh-mysql`**

SSH into MySQL console

### Deployment Operations

**`./aws.sh deploy`**

Deploy current branch to Elastic Beanstalk environment.

If application doesn't exists, it creates the application. If environment doesn't exist, it creates the environment. If environment exists, it updates the environment.

**`./aws.sh terminate`**

Terminate the Elastic Beanstalk environment of current branch.

**`./aws.sh terminate app`**

Terminate the application and all of its Elastic Beanstalk environments (all branches).

**`./delete-s3.sh [s3-bucket] [how-many-days-old]`**

*Example:* `./delete-s3.sh "s3://mys3bucket/apps/my-app/master" "7 days"`

### MISC Scripts

**`./mysql-local.sh`**

Connect to MySQL running in the Docker container.

**`./mysql-remote.sh`**

Connect to RDS MySQL console.

**`./ebs-ssh`**

SSH into current branch's EBS server console.

**`dump-db.sh [branch]`**

Dump database into a SQL file under project root directory. If `branch` parameter is not specified, current branch's database will be dumped.

**`export.sh [export-path]`**

Export all WordPress content into a ZIP file. Database export is not included.

**`open.sh`**

Open WordPress site in the default browser.

**`open-phpmyadmin.sh`**

Open phpMyAdmin in the default browser.

If `connectLocalMysqlForDev` is `true`, you can login using the configured username and password.
If `connectLocalMysqlForDev` is `false`, you can login using database credentials found in `db.json`

**`./list-stacks.sh`**

This returns a list of most current stacks available in AWS.

**`./list-mysql.sh`**

This returns a list of most curent MySQL versions available in AWS.

**`push-db.sh [origin-branch] [destination-branch]`**

Push datbase from `origin-branch` to `destination-branch`

**`push-db-from-local-to-dev.sh`**

Shortcut for `push-db.sh local dev`

**`push-db-from-dev-to-local.sh`**

Shortcut for `push-db.sh dev local`

**`push-db-from-dev-to-qa.sh`**

Shortcut for `push-db.sh dev qa`

**`push-db-from-dev-to-live.sh`**

Shortcut for `push-db.sh dev live`

**`push-db-from-qa-to-live.sh`**

Shortcut for `push-db.sh qa live`

**`sync-images.sh [origin-branch] [destination-branch]`**

Push datbase from `origin-branch` to `destination-branch`

**`sync-images-from-dev-to-qa.sh`**

Shortcut for `sync-image.sh dev qa`

**`sync-images-from-dev-to-live.sh`**

Shortcut for `sync-image.sh dev live`

**`sync-images-from-qa-to-live.sh`**

Shortcut for `sync-image.sh qa live`

**`install-pro-plugins`**

Download paid plugins from S3 and install them.

If `pluginsDownloadFromS3` in `app.json` has been changed, you need to run it manually to reinstall.

## Environment Migration
Push db first then image
 
## Maintenance

### Database Re-initialization

Database is installed upon the execution of `rd.sh` or `rds-existing.sh`. You can reinstall database if you need to.

**To install clean database**

`./load-db.sh db/wordpress.sql`

The clean database will not have any plugins activated. The admin login for this installation is "admin/password".

**To initialize application configurations**

`./reset-wordpress.sh 1`

The parameter value `1` will activate all the base plugins.

### EBS Instance Upgrade

Whenever you update one the following Elastic Beanstalk configurations, you will need to terminate the environment and re-deploy.
* `ec2SecurityGroups`
* `elbSecurityGroups`
* `iamInstanceProfile`
* `ec2KeyName`
* `stack`
* `instanceType`
* `tags`
* `sslCertificateId`

Do `./aws.sh terminate`, wait for it to complete, then `./aws.sh deploy`

### Local Database
If `connectLocalMysqlForDev` is `true` and you're in `dev` branch,  you will be connected to MySQL running in the Docker container. 

Raw data is saved under `./mysql`. Docker operations (`./docker.sh build` and `./docker.sh remove`) will not affect the data.

## Third Party Integrations

### recaptcha
https://www.google.com/recaptcha
 * Add your domain and `localhost`

## Domain/SSL Management

### Domain Name Registered in AWS

#### Coming...

### Domain Name Registered Elsewhere

1. Go to *Route 53* -> *Create Hosted Zone* (public hosted zone). By default, a hosted zone gets 4 AWS NS(Nameserver) records.
   Examples: ns-459.awsdns-57.com, ns-1696.awsdns-20.co.uk, ns-598.awsdns-10.net, ns-1194.awsdns-21.org
2. Go to your domain name provider account, remove all existing NS records, add 4 AWS NS records
3. [Check DNS propagation](#https://dnschecker.org/), it should take from 15 minutes to 24 hours to fully propagate
4. Deply at least one branch to AWS
5. Click on **Create Record Set**
   1. Enter the branch name in the **Name** field. For `master` branch, the live site, leave it blank
   2. **Type**: A - IPv4 address
   3. **Alias**: Yes
   4. **Alias Target**: select a CNME under Elastic Beanstalk environments, eg: mywordpress-dev.us-east-1.elasticbeanstalk.com
   5. **Create**
6. The domain should bring up the site in browser

### SSL Certificate
1. Go to **Certificate Manager** -> **Request a certificate** -> **Request a public certificate**
2. Add domain names: `domain.com` and `*.domain.com`. `*.domain.name` will cover all subdomains including `www`
3. Select *DNS validation*, **Review**, then *Confirm and request*
   1. Each domain shows "Pending validation status"
   2. For each domain, Click *Create record in Route 53*. This will create additional CNAME records in route53 for validation
   3. Wait for few mins you will see status changed to **Issued**
4. Look at doamin *Details*, copy the *ARN* string
5. Paste the *ARN* string in `app.json` as the `sslCertificateId` value
6. Re-deploy the branch. The site will be SSL secured instance is updated

### Simple Email Service (SES)
If you would like AWS as your SMTP server
1. Verify your email, go to **SES** -> **Email Addresses** -> **Verify a New Email Address**
2. Domains -> Verify a New Domain
   1. Enter a **Domain** and check **Generate DKIM settings**
   2. Click **Use Route53** -> **Create Record Sets**. This will create additional DNS records in route53 for verification
   3. The **Verification Status** will go from "pending verification" to "verified" status
3. Go to **SMTP Settings** -> **Create My SMTP Credentials**. It will create an AWS user with SMTP permissions. Save the SMTP username and password
4. Copy and paste the SMTP username and password into `app.json`, the SMTP configs will look like
 ``
 "smtpHost": "email-smtp.us-east-1.amazonaws.com",
 "smtpPort": 587,
 "smtpUsername": "xxxxxxxxxx",
 "smtpPassword": "xxxxxxxxxx"
``
5. Re-deploy the branch

### Other Notes
- Eleastic Beanstalk will create a default security group with *Inbound* rules of 80 and 22
  - Load balancer will forward traffics from both port 80 and 443 to port 80 on the instance, the instance itself doesn't need port 443 to be open.
  - Port 22 allows SSH connection from anywhere in the world but key pair has to be specified

## Forking
### Coming...

## Tested Platforms

* Ubuntu 16 LTS
* macOS High Serria

## Licensing
MIT - See included LICENSE.md
