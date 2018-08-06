FROM amazonlinux:latest
MAINTAINER Alan Zhao <alanzhaonys@yahoo.com>

# Install packages
RUN yum update -y
RUN amazon-linux-extras install php7.2 -y
RUN yum install vim jq php-soap php-xml php-mbstring httpd mod_php -y

# Change Apache server name
RUN sed -i -e "s/#ServerName www.example.com:80/ServerName localhost/g" /etc/httpd/conf/httpd.conf

# Allow .htaccess
RUN sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/AllowOverride none/AllowOverride All/g" /etc/httpd/conf/httpd.conf

# Change system timezone
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Change PHP timezone
RUN sed -i -e "s/;date.timezone =/date.timezone = America\/New_York/g" /etc/php.ini

# Add app.json to tmp directory for use later
ADD app.json /tmp/

# Other MISC PHP settings
RUN PHP_MEMORY_LIMIT=$(jq -r ".php.dev.memoryLimit" /tmp/app.json) \
  && PHP_OUTPUT_COMPRESSION=$(jq -r ".php.dev.outputCompression" /tmp/app.json) \
  && PHP_ALLOW_URL_FOPEN=$(jq -r ".php.dev.allowUrlFopen" /tmp/app.json) \
  && PHP_DISPLAY_ERRORS=$(jq -r ".php.dev.displayErrors" /tmp/app.json) \
  && PHP_MAX_EXECUTION_TIME=$(jq -r ".php.dev.maxExecutionTime" /tmp/app.json) \
  && PHP_UPLOAD_MAX_FILESIZE=$(jq -r ".php.dev.uploadMaxFilesize" /tmp/app.json) \
  && PHP_POST_MAX_SIZE=$(jq -r ".php.dev.postMaxSize" /tmp/app.json) \
  && sed -i -e "s/memory_limit = .*/memory_limit = ${PHP_MEMORY_LIMIT}/g" /etc/php.ini \
  && sed -i -e "s/zlib.output_compression = .*/zlib.output_compression = ${PHP_OUTPUT_COMPRESSION}/g" /etc/php.ini \
  && sed -i -e "s/allow_url_fopen = .*/allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}/g" /etc/php.ini \
  && sed -i -e "s/display_errors = .*/display_errors = ${PHP_DISPLAY_ERRORS}/g" /etc/php.ini \
  && sed -i -e "s/max_execution_time = .*/max_execution_time = ${PHP_MAX_EXECUTION_TIME}/g" /etc/php.ini \
  && sed -i -e "s/upload_max_filesize = .*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/g" /etc/php.ini \
  && sed -i -e "s/post_max_size = .*/post_max_size = ${PHP_POST_MAX_SIZE}/g" /etc/php.ini

# Done with app.json, remove
RUN rm /tmp/app.json

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
