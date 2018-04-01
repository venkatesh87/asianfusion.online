FROM amazonlinux:latest
MAINTAINER Alan Zhao <alanzhaonys@yahoo.com>

# Install packages
RUN yum update -y
RUN yum install vim jq httpd24 php71 php71-mbstring php71-mcrypt php71-memcache php71-gd php71-mysqlnd -y

RUN echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

# Change Apache server name
RUN sed -i -e "s/#ServerName www.example.com:80/ServerName localhost/g" /etc/httpd/conf/httpd.conf

# Allow .htaccess
RUN sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf

# Change PHP timezone
RUN sed -i -e "s/;date.timezone =/date.timezone = America\/New_York/g" /etc/php-7.1.ini

# Change system timezone
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Enable networking
RUN echo "NETWORKING=yes" >/etc/sysconfig/network

# Add app.json to tmp directory
ADD app.json /tmp/

# Get public web directory configuration
RUN PUBLIC_WEB_DIR=$(jq -r ".publicWebDir" /tmp/app.json)

# Remove app.json
RUN rm /tmp/app.json

# Mount public web directory
ADD ./$PUBLIC_WEB_DIR /var/www/html

# Configure public web directory volume
VOLUME /var/www/html

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
