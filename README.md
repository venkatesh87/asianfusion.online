INSTALLATION

AWS
======

Network & Security -> Security Groups
  * Create new Security Group for EC2 and EBS
    * Allow Inbound from Anywhere on SSH, HTTP, HTTPS
  * Create new Security Group for RDS
    * Allow Inbound from Anywhere on MYSQL

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

SES
  * Email Addresses -> Verify a New Email Address
  * Domains -> Verify a New Domain (Generate DKIM settings)
    * This will create additional CNAME records in route53 for domain verification
  * SMTP Settings -> Create My SMTP Credentials

Certificate Manager
  * Add domain names: www.domain.com, domain.com, *.domain.com
   * Select DNS validation. Under each domain, do Create record in Route 53.
    This will create additional CNAME records in route53 for validation

NOTE: If you setup environment under different accounts, you need to repeat steps above for each account

AWS Profile
===========
IAM -> Users -> Security credentials -> Create access key

aws configure list
set AWS_PROFILE=default

* When switching instanceType, please terminate the EBS instance and re-deploy
* Initial password:
  admin/password
  * After deployment:
    admin/whatever set in the app.json

RDS
===
run ./rds

run ./load-db.sh db/wordpress.sql

EBS
