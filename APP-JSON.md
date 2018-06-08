{
  "appName": "change-me",
  "publicWebDir": "wordpress",
  "connectLocalMysqlForDev": 0,
  "docker": {
    "wordpress": {
      "name": "change-me",
      "port": "8500"
    },
    "phpmyadmin": {
      "port": "8501"
    },
    "mysql": {
      "port": "3307",
      "username": "admin",
      "password": "password"
    }
  },
  "aws": {
    "dev": {
      "profile": "change-me",
      "ec2SecurityGroups": "",
      "elbSecurityGroups": "",
      "iamInstanceProfile": "",
      "ec2KeyName": "",
      "ec2KeyPath": "",
      "stack": "64bit Amazon Linux 2018.03 v2.7.0 running PHP 7.1",
      "instanceType": "t2.micro", 
      "tags": "Key=Environment,Value=Development Key=Application,Value=Wordpress"
    },
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
    "wordpressUploadS3Bucket": "change-me",
    "appS3Bucket": "change-me",
    "credsS3Bucket": "change-me",
    "pluginS3Bucket": "change-me",
    "s3AccessKeyId": "change-me",
    "s3SecretAccessKey": "change-me",
    "appS3Delete": 1,
    "appS3DeleteDaysOld": 7,
    "sslCertificateId": ""
  },
  "rds": {
    "instanceName": "change-me",
    "instanceClass": "db.t2.micro",
    "dbSecurityGroups": "",
    "region": "us-east-1",
    "allocatedStorage": 20,
    "storageType": "gp2",
    "engine": "mysql",
    "engineVersion": "5.7.21"
  },
  "wpEmailSmtp": {
    "dev": {
      "fromEmail": "",
      "fromName": "",
      "smtpHost": "email-smtp.us-east-1.amazonaws.com",
      "smtpPort": 587,
      "smtpUsername": "",
      "smtpPassword": ""
    },
    "qa": {
      "fromEmail": "",
      "fromName": "",
      "smtpHost": "email-smtp.us-east-1.amazonaws.com",
      "smtpPort": 587,
      "smtpUsername": "",
      "smtpPassword": ""
    },
    "master": {
      "fromEmail": "",
      "fromName": "",
      "smtpHost": "email-smtp.us-east-1.amazonaws.com",
      "smtpPort": 587,
      "smtpUsername": "",
      "smtpPassword": ""
    }
  },
  "php": {
    "dev": {
      "memoryLimit": "512M",
      "outputCompression": "Off",
      "allowUrlFopen": "Off",
      "displayErrors": "On",
      "maxExecutionTime": 60,
      "uploadMaxFilesize": "20M",
      "postMaxSize": "2M"
    },
    "qa": {
      "memoryLimit": "512M",
      "outputCompression": "On",
      "allowUrlFopen": "Off",
      "displayErrors": "Off",
      "maxExecutionTime": 60,
      "uploadMaxFilesize": "20M",
      "postMaxSize": "2M"
    },
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
  "wordpress": {
    "siteTitle": "change-me",
    "tagline": "",
    "pluginsDownloadFromS3": "",
    "apiKey": "",
    "loginUrl": "backend",
    "enableEmoji": 0,
    "recaptcha": {
      "siteKey": "",
      "secretKey": ""
    },
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
    "dev": {
      "minifyHtml": 0,
      "adminUsername": "change-me",
      "adminPassword": "change-me",
      "adminDisplayName": "change-me",
      "adminEmail": "change-me"
    },
    "qa": {
      "minifyHtml": 1,
      "adminUsername": "change-me",
      "adminPassword": "change-me",
      "adminDisplayName": "change-me",
      "adminEmail": "change-me"
    },
    "master": {
      "minifyHtml": 1,
      "adminUsername": "change-me",
      "adminPassword": "change-me",
      "adminDisplayName": "change-me",
      "adminEmail": "change-me"
    }
  },
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
