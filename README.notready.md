INSTALLATION

AWS
======

Network & Security -> Security Groups
  * EBS create security groups automatically by default port 80, 442
  * If key pair is specified, port 22 will be open in the security group

Network & Security -> Key Pairs
  * Create new Key Pair
  * Save it and chmod it to 600

S3
  * Create bucket
  s3://[BUCKET-NAME]/[APP-NAME]/[APP-BRANCH]/[APP-FILE-VERSIONED].zip

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

aws configure list
set AWS_PROFILE=default

* When switching instanceType, please terminate the EBS instance and re-deploy
  * After deployment:
    admin/whatever set in the app.json

AWS User
==========
Add User -> Programmtic access -> Attach existing policies directly -> AmazonS3FullAccess -> Get Access Key ID/Screct access key


RDS
===
run ./rds

run ./load-db.sh db/wordpress.sql

SSH access
=========
Don't specify ec2 key name and path if you don't want SSH access. EBS will create the default
security group with port 22 open if ec2 key name is specified.

ebextensions

Integration
==========
recaptcha
 * Add your domain and localhost

Cost


Global header and footer setup
============================
Plugins:
Elementor 
Header Footer Elementor
Max Mega Menu

1. Create a new Menu
2. Menu Settings -> Display Location -> Primary Menu
3. Appearance -> Menus -> Max Mega Menu Settings -> Enable -> Save
5. Appearance -> Header Footer Builder -> Select the type of template this is "Header"
-> Edit Elementor -> Add Template -> My Templates -> "Header" -> Insert -> Update
