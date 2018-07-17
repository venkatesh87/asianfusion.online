Set up steps:

1. bistrosol-create.sh 
   - This create EC2 instance

2. bistrosol-run-setup.sh
   - This sets up EC2 instance

3. bistrosol-db-create.sh
   - This sets up MySQL users and loads bistrosolutions.sql database

To check if SSL is enabled for MySQL

 mysql> show variables like '%ssl%';

  or

 \s
