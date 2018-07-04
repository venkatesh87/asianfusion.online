#!/bin/bash

SERVER_ID=1000

# Install packages
sudo yum update -y
sudo yum install jq httpd mod_ssl -y
sudo amazon-linux-extras install php7.2 -y

# MySQL 8 - https://dev.mysql.com/doc/refman/8.0/en/linux-installation-yum-repo.html
wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
sudo yum localinstall mysql80-community-release-el7-1.noarch.rpm -y
sudo yum install mysql-community-server -y

# Change Apache server name
sudo sed -i -e "s/#ServerName www.example.com:80/ServerName localhost/g" /etc/httpd/conf/httpd.conf

# Allow .htaccess
sudo sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf
sudo sed -i -e "s/AllowOverride none/AllowOverride All/g" /etc/httpd/conf/httpd.conf

# Change system timezone
sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Change PHP timezone
sudo sed -i -e "s/;date.timezone =/date.timezone = America\/New_York/g" /etc/php.ini

# Allow outside access to MySQL
# Lower password policy - https://dev.mysql.com/doc/refman/8.0/en/validate-password-options-variables.html
# Set server_id global variable
sudo sed -i -e "s/\[mysqld\]/\[mysqld\]\nbind-address = 0.0.0.0\nvalidate_password.policy=LOW\nserver_id=${SERVER_ID}\n/g" /etc/my.cnf

# Other MISC PHP settings
PHP_MEMORY_LIMIT=$(jq -r ".php.dev.memoryLimit" /tmp/bistrosol.json)
PHP_OUTPUT_COMPRESSION=$(jq -r ".php.dev.outputCompression" /tmp/bistrosol.json)
PHP_ALLOW_URL_FOPEN=$(jq -r ".php.dev.allowUrlFopen" /tmp/bistrosol.json)
PHP_DISPLAY_ERRORS=$(jq -r ".php.dev.displayErrors" /tmp/bistrosol.json)
PHP_MAX_EXECUTION_TIME=$(jq -r ".php.dev.maxExecutionTime" /tmp/bistrosol.json)
PHP_UPLOAD_MAX_FILESIZE=$(jq -r ".php.dev.uploadMaxFilesize" /tmp/bistrosol.json)
PHP_POST_MAX_SIZE=$(jq -r ".php.dev.postMaxSize" /tmp/bistrosol.json)

sudo sed -i -e "s/memory_limit = .*/memory_limit = ${PHP_MEMORY_LIMIT}/g" /etc/php.ini
sudo sed -i -e "s/zlib.output_compression = .*/zlib.output_compression = ${PHP_OUTPUT_COMPRESSION}/g" /etc/php.ini
sudo sed -i -e "s/allow_url_fopen = .*/allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}/g" /etc/php.ini
sudo sed -i -e "s/display_errors = .*/display_errors = ${PHP_DISPLAY_ERRORS}/g" /etc/php.ini
sudo sed -i -e "s/max_execution_time = .*/max_execution_time = ${PHP_MAX_EXECUTION_TIME}/g" /etc/php.ini
sudo sed -i -e "s/upload_max_filesize = .*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/g" /etc/php.ini
sudo sed -i -e "s/post_max_size = .*/post_max_size = ${PHP_POST_MAX_SIZE}/g" /etc/php.ini

# Default site
echo "<VirtualHost *:80>

    ServerName localhost
    
    DocumentRoot /var/www/000-default

    <Directory /var/www/000-default>
        AllowOverride All
    </Directory>

    ErrorLog /var/log/httpd/000-default_error.log
    LogLevel debug
    CustomLog /var/log/httpd/000-default_access.log combined

</VirtualHost>" | sudo tee /etc/httpd/conf.d/000-default.conf > /dev/null 2>&1

sudo mkdir /var/www/000-default

echo "<?php phpinfo();" | sudo tee /var/www/000-default/phpinfo.php > /dev/null 2>&1

sudo chown -R apache:apache /var/www

# Start MySQL now, start MySQL on boot, output MySQL status
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo systemctl status mysqld

# Start httpd now, start httpd on boot, output httpd status
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd

# Get password
get_password() {
  password=$(openssl rand -base64 29 | tr -d "=+/" | cut -c1-25)
  echo $password
}

readonly MYSQL_TEMP_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | sed 's/.* //')
readonly MYSQL_ROOT_PASSWORD=$(get_password)

# Add MySQL root password
mysql -hlocalhost -uroot -p${MYSQL_TEMP_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Add MySQL root user for outside access
mysql -hlocalhost -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -hlocalhost -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* to root@'%' WITH GRANT OPTION;"

# Flush privileges
mysql -hlocalhost -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Create /tmp/bistrosol-db.json
echo "{
  \"root\": {
    \"endpoint\": \"\",
    \"user\": \"root\",
    \"password\": \"$MYSQL_ROOT_PASSWORD\",
    \"port\": \"\"
  }
}" > /tmp/bistrosol-db.json
