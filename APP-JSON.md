Search for `change-me`, they are the values you most likely need to change.

```
{
  
  // A short application name
  "appName": "change-me",
  
  // The domain name of this site
  "domainName": "",

  // Act as the "ServerAlias" Apache config
  "domainAlias": "",
  
  // Directory where WordPress source code is
  "publicWebDir": "wordpress",
  
  // Whether or not the dev branch should connect to local MySQL
  "connectLocalMysqlForDev": 0,
  
  // Docker configurations
  "docker": {
    "wordpress": {
      // WordPress container name
      "name": "change-me",
      
      // WordPress container port, this should be unique
      "port": "8500"
    },
    "phpmyadmin": {
      // phpMyAdmin container port, this should be unique
      "port": "8501"
    },
    "mysql": {
      // MySQL container port, this should be unique
      "port": "3307",
      
      // MySQL root user name
      "username": "admin",
      
      // MySQL root password
      "password": "password"
    }
  },
  
  "aws": {
  
    // For dev branch
    "dev": {
    
      // AWS profile to use
      "profile": "change-me",
      
      // Additional EC2 security groups
      "ec2SecurityGroups": "",
      
      // Additional load balancer security groups
      "elbSecurityGroups": "",
      
      // A user role for the EC2 instance, specifying this will make code change deployment
      // to complete fast.
      // https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html
      // https://aws.amazon.com/blogs/security/new-attach-an-aws-iam-role-to-an-existing-amazon-ec2-instance-by-using-the-aws-cli/
      // https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html
      "iamInstanceProfile": "",
      
      // The name of the EC2 key to SSH into ElasticBeanstalk
      // Generally you won't need SSH access for QA and Master branches,
      // but there is a chance you need it for dev for debugging purpose.
      "ec2KeyName": "",
      
      // The path of the key file (.pem file)
      "ec2KeyPath": "",
      
      // Base server stack
      "stack": "64bit Amazon Linux 2018.03 v2.7.0 running PHP 7.1",
      
      // Server type
      "instanceType": "t2.micro", 
      
      // Enviornment tags
      "tags": "Key=Environment,Value=Development Key=Application,Value=Wordpress"
    },
    
    // See comments for "dev" above
    "qa": {
      "profile": "change-me",
      "ec2SecurityGroups": "",
      "elbSecurityGroups": "",
      "iamInstanceProfile": "",
      "ec2KeyName": "",
      "ec2KeyPath": "",
      "stack": "64bit Amazon Linux 2018.03 v2.7.0 running PHP 7.1",
      "instanceType": "t2.micro",
      "tags": "Key=Environment,Value=QA Key=Application,Value=Wordpress"
    },
    
    // See comments for "dev" above
    "master": {
      "profile": "change-me",
      "ec2SecurityGroups": "",
      "elbSecurityGroups": "",
      "iamInstanceProfile": "",
      "ec2KeyName": "",
      "ec2KeyPath": "",
      "stack": "64bit Amazon Linux 2018.03 v2.7.0 running PHP 7.1",
      "instanceType": "t2.micro",
      "tags": "Key=Environment,Value=Live Key=Application,Value=Wordpress"
    },
    
    // S3 bucket for WordPress uploads
    "wordpressUploadS3Bucket": "change-me",
    
    // S3 bucket for application files
    "appS3Bucket": "change-me",
    
    // S3 bucket for app.json and db.json
    "credsS3Bucket": "change-me",
    
    // S3 bucket for WordPress paid plugins
    "pluginS3Bucket": "change-me",

    // S3 bucket for database backup files
    "dbBackupS3Bucket": "change-me",
    
    // AWS user Access Key ID with S3 permissions. This is used by Offload S3 plugin.
    "s3AccessKeyId": "change-me",
    
    // AWS user Secret Access Key with S3 permissions. This is used by Offload S3 plugin.
    "s3SecretAccessKey": "change-me",
    
    // Whether or not upon a new deployment, old application files should be deleted from S3.
    "appS3Delete": 1,
    
    // Use in conjunction with above to delete application files that are "x" days old.
    "appS3DeleteDaysOld": 7,
    
    // The SSL certificate ID to use for all the environments. Refer to main README for setup instructions.
    // It's a string like: arn:aws:acm:us-east-1:xxxx:certificate/xxxx-xxxx-xxxx-xxxx-xxxx
    "sslCertificateId": ""
  },
  
  "rds": {
  
    // The database name, keep it equal or less than 11 characters.
    "instanceName": "change-me",
    
    // Database server type
    "instanceClass": "db.t2.micro",
    
    // Additional RDS security groups to add
    "dbSecurityGroups": "",
    
    // RDS region
    "region": "us-east-1",
    
    // RDS disk space
    "allocatedStorage": 20,
    
    // General Purpose (SSD) storage
    "storageType": "gp2",
    
    // MySQL
    "engine": "mysql",
    
    // MySQL version
    "engineVersion": "5.7.21"
  },
  
  // WP Email Smtp plugin settings
  "wpEmailSmtp": {
    
    // For "dev" branch
    "dev": {
      
      // "From" email
      "fromEmail": "",
      
      // "From" name
      "fromName": "",
      
      // AWS SES host or your choice of other SMTP host
      "smtpHost": "email-smtp.us-east-1.amazonaws.com",
      
      // SMTP port
      "smtpPort": 587,
      
      // SMTP username
      "smtpUsername": "",
      
      // SMTP password
      "smtpPassword": ""
    },
    
    // See comments for "dev" above
    "qa": {
      "fromEmail": "",
      "fromName": "",
      "smtpHost": "email-smtp.us-east-1.amazonaws.com",
      "smtpPort": 587,
      "smtpUsername": "",
      "smtpPassword": ""
    },
    
    // See comments for "dev" above
    "master": {
      "fromEmail": "",
      "fromName": "",
      "smtpHost": "email-smtp.us-east-1.amazonaws.com",
      "smtpPort": 587,
      "smtpUsername": "",
      "smtpPassword": ""
    }
  },
  
  // PHP settings
  "php": {
  
    // See PHP manual: http://php.net/manual/en/ini.list.php
    "dev": {
      "memoryLimit": "512M",
      "outputCompression": "Off",
      "allowUrlFopen": "Off",
      "displayErrors": "On",
      "maxExecutionTime": 60,
      "uploadMaxFilesize": "20M",
      "postMaxSize": "2M"
    },
    
    // See PHP manual: http://php.net/manual/en/ini.list.php
    "qa": {
      "memoryLimit": "512M",
      "outputCompression": "On",
      "allowUrlFopen": "Off",
      "displayErrors": "Off",
      "maxExecutionTime": 60,
      "uploadMaxFilesize": "20M",
      "postMaxSize": "2M"
    },
    
    // See PHP manual: http://php.net/manual/en/ini.list.php
    "master": {
      "memoryLimit": "512M",
      "outputCompression": "On",
      "allowUrlFopen": "Off",
      "displayErrors": "Off",
      "maxExecutionTime": 60,
      "uploadMaxFilesize": "20M",
      "postMaxSize": "2M"
    }
  },
  
  // WordPress general settings
  "wordpress": {
  
    // WordPress site title. This will update the database on every deployment
    "siteTitle": "change-me",
    
    // WordPress site tag line. This will update the database on every deployment
    "tagline": "",
    
    // Premium plugins to download from S3. eg: "elementor-pro:elementor-pro-2.0.9.zip,more-plugin:more-plugin.zip".
    // Format: WordPress plugn directory name:File name on S3
    // Plugins defined here won't get commited and but will get pushed to ElasticBeanstalk
    // Plugins will download and install on every deployment
    "pluginsDownloadFromS3": "",
    
    // https://akismet.com/ - Akismet API key, sign up and add site
    "apiKey": "",
    
    // The URL to relace /wp-admin with. This uses the WPS Hide plugin
    "loginUrl": "backend",
    
    // Whether or not Emoji should be enabled
    "enableEmoji": 0,
    
    // https://www.google.com/recaptcha, sign up and add domain(don't forget `localhost`)
    "recaptcha": {
      "siteKey": "",
      "secretKey": ""
    },
    
    // Predefined WordPress users, add as many users as you want
    // Valid roles are: adminstrator, author, editor, subscriber, contributor
    // If Yoast SEO is installed, these roles are also available: wpseo_editor, wpseo_manager
    "users": {
      "user1": {
        "username": "",
        "password": "",
        "email": "",
        "role": "adminstrator",
        "userNicename": "",
        "displayName": ""
      },
      
      "user2": {
        "username": "",
        "password": "",
        "email": "",
        "role": "adminstrator",
        "userNicename": "",
        "displayName": ""
      },
      
      "user3": {
        "username": "",
        "password": "",
        "email": "",
        "role": "editor",
        "userNicename": "",
        "displayName": ""
      },
      
      "user4": {
        "username": "",
        "password": "",
        "email": "",
        "role": "author",
        "userNicename": "",
        "displayName": ""
      }
    },
    
    // For "dev" branch
    "dev": {
    
      // Whether or not to minify the HTML. This uses the Minify HTML plugin.
      "minifyHtml": 0,
      
      // The master admin information. This replaces the default admin in clean database.
      "adminUsername": "change-me",
      "adminPassword": "change-me",
      "adminDisplayName": "change-me",
      "adminEmail": "change-me"
    },
    
    // See comments for "dev" above
    "qa": {
      "minifyHtml": 1,
      "adminUsername": "change-me",
      "adminPassword": "change-me",
      "adminDisplayName": "change-me",
      "adminEmail": "change-me"
    },
    
    // See comments for "dev" above
    "master": {
      "minifyHtml": 1,
      "adminUsername": "change-me",
      "adminPassword": "change-me",
      "adminDisplayName": "change-me",
      "adminEmail": "change-me"
    }
  },
  
  // Basic auth settings
  "basicAuth": {
    "dev": {
      "enabled": 0,
      "user": "",
      "password": ""
    },
    "qa": {
      "enabled": 0,
      "user": "",
      "password": ""
    },
    "master": {
      "enabled": 0,
      "user": "",
      "password": ""
    }
  }
}
```
