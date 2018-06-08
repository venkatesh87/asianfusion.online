## Introduction
This repository contains
* bash scripts to automate AWS deployment
* WordPress base installation and plugins files

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

Command:
`aws s3api create-bucket --bucket your-bucket --profile your-profile --region us-east-1`

You can also create buckets using S3 console.

#### Application Bucket
Bucket for application files

#### Application Credential Bucket
Bucket for app.json and db.json

#### Wordpress Upload Bucket
Bucket for Wordpress uploads

#### Wordpress Plugin Bucket
Bucket for Wordpress paid plugins

#### Create S3 User Wordpress Upload
Create user with S3 programtic access only, get Access key ID and Secret access key for Wordpress S3 upload plugin

Add User -> Programmtic access -> Attach existing policies directly -> AmazonS3FullAccess -> Get Access Key ID/Screct access key

`
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
`
https://deliciousbrains.com/wp-offload-s3/doc/quick-start-guide/

### app.json

`cp app.sample.json app.json`

See app.json configuration details here

## Usage

### ./rds.sh

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

### ./list-stacks.sh
This return a list of most current stacks available in AWS.



recaptcha
 * Add your domain and localhost

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
