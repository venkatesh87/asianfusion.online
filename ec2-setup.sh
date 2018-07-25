#!/bin/bash

# Install packages
sudo yum update -y
sudo amazon-linux-extras install php7.2 php-mbstring -y
sudo yum install jq httpd mod_php mod_ssl -y

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
# https://mysqlserverteam.com/upgrading-to-mysql-8-0-default-authentication-plugin-considerations/
# Also change MySQL 8 password authentication to mysql_native_password for compatibility
sudo sed -i -e "s/\[mysqld\]/\[mysqld\]\nbind-address = 0.0.0.0\n#validate_password.policy=LOW\ndefault-authentication-plugin=mysql_native_password\n/g" /etc/my.cnf

# Server configs
SERVER_NAME=$(jq -r ".serverName" /tmp/ec2.json)

# Other MISC PHP settings
PHP_MEMORY_LIMIT=$(jq -r ".php.dev.memoryLimit" /tmp/ec2.json)
PHP_OUTPUT_COMPRESSION=$(jq -r ".php.dev.outputCompression" /tmp/ec2.json)
PHP_ALLOW_URL_FOPEN=$(jq -r ".php.dev.allowUrlFopen" /tmp/ec2.json)
PHP_DISPLAY_ERRORS=$(jq -r ".php.dev.displayErrors" /tmp/ec2.json)
PHP_MAX_EXECUTION_TIME=$(jq -r ".php.dev.maxExecutionTime" /tmp/ec2.json)
PHP_UPLOAD_MAX_FILESIZE=$(jq -r ".php.dev.uploadMaxFilesize" /tmp/ec2.json)
PHP_POST_MAX_SIZE=$(jq -r ".php.dev.postMaxSize" /tmp/ec2.json)

sudo sed -i -e "s/memory_limit = .*/memory_limit = ${PHP_MEMORY_LIMIT}/g" /etc/php.ini
sudo sed -i -e "s/zlib.output_compression = .*/zlib.output_compression = ${PHP_OUTPUT_COMPRESSION}/g" /etc/php.ini
sudo sed -i -e "s/allow_url_fopen = .*/allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}/g" /etc/php.ini
sudo sed -i -e "s/display_errors = .*/display_errors = ${PHP_DISPLAY_ERRORS}/g" /etc/php.ini
sudo sed -i -e "s/max_execution_time = .*/max_execution_time = ${PHP_MAX_EXECUTION_TIME}/g" /etc/php.ini
sudo sed -i -e "s/upload_max_filesize = .*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/g" /etc/php.ini
sudo sed -i -e "s/post_max_size = .*/post_max_size = ${PHP_POST_MAX_SIZE}/g" /etc/php.ini

# Make directory for htpassword
sudo mkdir -p /etc/httpd/htpasswd

# Make directory for SSL certs
sudo mkdir -p /etc/httpd/certs

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

</VirtualHost>

<VirtualHost *:443>

    ServerName ${SERVER_NAME}

    DocumentRoot /var/www/000-default

    <Directory /var/www/000-default>
        AllowOverride All
    </Directory>

    SSLEngine On
    SSLCertificateFile /etc/httpd/certs/${SERVER_NAME}/cert.pem
    SSLCertificateKeyFile /etc/httpd/certs/${SERVER_NAME}/privkey.pem
    SSLCertificateChainFile /etc/httpd/certs/${SERVER_NAME}/chain.pem

    ErrorLog /var/log/httpd/000-default_error.log
    LogLevel debug
    CustomLog /var/log/httpd/000-default_access.log combined

</VirtualHost>

# https://www.acunetix.com/blog/articles/tls-ssl-cipher-hardening/
# https://www.ssllabs.com/ssltest/index.html
# https://www.digicert.com/help/

# Enable TLSv1.2, disable SSLv3.0, TLSv1.0 and TLSv1.1
SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1

# Enable modern TLS cipher suites
SSLCipherSuite ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256

# The order of cipher suites matters
SSLHonorCipherOrder on

# Disable TLS compression
SSLCompression off

# Necessary for Perfect Forward Secrecy (PFS)
SSLSessionTickets off" | sudo tee /etc/httpd/conf.d/000-default.conf > /dev/null 2>&1

sudo mkdir /var/www/000-default

echo '<h2 style="font-size:50px;width:100%;height:100%;display:flex;justify-content:center;align-items:center;">Sorry, the page cannot be found!</h2>' | sudo tee /var/www/000-default/index.html > /dev/null 2>&1

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www

chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

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

MYSQL_TEMP_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | sed 's/.* //')
MYSQL_TEMP_ROOT_PASSWORD='Test12345%'
MYSQL_ROOT_PASSWORD=$(get_password)

# MySQL 8 creates root user with temporary password by default.
# On first password reset, it requires secure password
# http://mysqlblog.fivefarmers.com/2014/05/20/batch-mode-and-expired-passwords/
mysql --connect-expired-password -hlocalhost -uroot --password="${MYSQL_TEMP_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_TEMP_ROOT_PASSWORD}';"

# Flush privileges
mysql -hlocalhost -uroot --password="${MYSQL_TEMP_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Stop
sudo systemctl stop mysqld

# Disable secure password
# Lower password policy - https://dev.mysql.com/doc/refman/8.0/en/validate-password-options-variables.html
sudo sed -i -e "s/#validate_password.policy=LOW/validate_password.policy=LOW/g" /etc/my.cnf

# Start
sudo systemctl start mysqld

# Now change MySQL root password for real
mysql -hlocalhost -uroot --password="${MYSQL_TEMP_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Add MySQL root user for outside access
mysql -hlocalhost -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -hlocalhost -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* to root@'%' WITH GRANT OPTION;"

# Flush privileges
mysql -hlocalhost -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Add timezone support
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -p${MYSQL_ROOT_PASSWORD} mysql

# Restart
sudo systemctl start mysqld

# Create /tmp/ec2-db.json
echo "{
  \"root\": {
    \"endpoint\": \"\",
    \"user\": \"root\",
    \"password\": \"$MYSQL_ROOT_PASSWORD\",
    \"port\": \"\"
  }
}" > /tmp/ec2-db.json
