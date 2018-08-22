1. cp app.json, ec2.json, ec2-db.json, default-ec2.pem from an existing repo
2. run ./ec2-create-db.sh to create database in EC2
3. Go to utilities
    run `sudo ./certbot.sh asianfusion.online`
    run `./sync-certs-up.sh`
4. Go back to repo, run `./ec2.sh deploy`
