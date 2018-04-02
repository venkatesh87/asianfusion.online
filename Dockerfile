FROM amazonlinux:latest
MAINTAINER Alan Zhao <alanzhaonys@yahoo.com>

# Install packages
RUN yum update -y
RUN yum install vim jq httpd24 php71 php71-mbstring php71-mcrypt php71-memcache php71-gd php71-mysqlnd -y

# Create phpinfo.php
RUN echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

# Change Apache server name
RUN sed -i -e "s/#ServerName www.example.com:80/ServerName localhost/g" /etc/httpd/conf/httpd.conf

# Allow .htaccess
RUN sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf

# Change system timezone
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Enable networking
RUN echo "NETWORKING=yes" >/etc/sysconfig/network

# Add app.json to tmp directory
ADD app.json /tmp/

# Get public web directory configuration
RUN PUBLIC_WEB_DIR=$(jq -r ".publicWebDir" /tmp/app.json)

# Change PHP timezone
RUN sed -i -e "s/;date.timezone =/date.timezone = America\/New_York/g" /etc/php-7.1.ini

# Other MISC PHP settings
RUN PHP_MEMORY_LIMIT=$(jq -r ".php.dev.memoryLimit" /tmp/app.json); \
  PHP_OUTPUT_COMPRESSION=$(jq -r ".php.dev.outputCompression" /tmp/app.json); \
  PHP_ALLOW_URL_FOPEN=$(jq -r ".php.dev.allowUrlFopen" /tmp/app.json); \
  PHP_DISPLAY_ERRORS=$(jq -r ".php.dev.displayErrors" /tmp/app.json); \
  PHP_MAX_EXECUTION_TIME=$(jq -r ".php.dev.maxExecutionTime" /tmp/app.json); \
  PHP_UPLOAD_MAX_FILESIZE=$(jq -r ".php.dev.uploadMaxFilesize" /tmp/app.json); \
  PHP_POST_MAX_SIZE=$(jq -r ".php.dev.postMaxSize" /tmp/app.json); \
  sed -i -e "s/memory_limit = 128M/memory_limit = ${PHP_MEMORY_LIMIT}/g" /etc/php-7.1.ini; \
  sed -i -e "s/zlib.output_compression = Off/zlib.output_compression = ${PHP_OUTPUT_COMPRESSION}/g" /etc/php-7.1.ini; \
  sed -i -e "s/allow_url_fopen = On/allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}/g" /etc/php-7.1.ini; \
  sed -i -e "s/display_errors = Off/display_errors = ${PHP_DISPLAY_ERRORS}/g" /etc/php-7.1.ini; \
  sed -i -e "s/max_execution_time = 30/max_execution_time = ${PHP_MAX_EXECUTION_TIME}/g" /etc/php-7.1.ini; \
  sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/g" /etc/php-7.1.ini; \
  sed -i -e "s/post_max_size = 8M/post_max_size = ${PHP_POST_MAX_SIZE}/g" /etc/php-7.1.ini

# Remove app.json
RUN rm /tmp/app.json

# Mount public web directory
ADD ./$PUBLIC_WEB_DIR /var/www/html

# Configure public web directory volume VOLUME /var/www/html

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
