#!/bin/bash

source ./variables.sh
source ./functions.sh

DB_HOST=$1
DB_DATABASE=$2
DB_USER=$3
DB_PASSWORD=$4
ACTIVATE_PREINSTALLED_PLUGINS=$5

# Wordpress admin info
readonly WP_ADMIN_USERNAME=$(jq -r ".wordpress.${APP_BRANCH}.adminUsername" $APP_CONFIG_FILE)
readonly WP_ADMIN_PASSWORD=$(jq -r ".wordpress.${APP_BRANCH}.adminPassword" $APP_CONFIG_FILE)
readonly WP_ADMIN_DISPLAY_NAME=$(jq -r ".wordpress.${APP_BRANCH}.adminDisplayName" $APP_CONFIG_FILE)
readonly WP_ADMIN_EMAIL=$(jq -r ".wordpress.${APP_BRANCH}.adminEmail" $APP_CONFIG_FILE)

# Wordpress email SMTP settings
readonly WP_EMAIL_SMTP_FROM_EMAIL=$(jq -r ".wpEmailSmtp.${APP_BRANCH}.fromEmail" $APP_CONFIG_FILE)
readonly WP_EMAIL_SMTP_FROM_NAME=$(jq -r ".wpEmailSmtp.${APP_BRANCH}.fromName" $APP_CONFIG_FILE)
readonly WP_EMAIL_SMTP_HOST=$(jq -r ".wpEmailSmtp.${APP_BRANCH}.smtpHost" $APP_CONFIG_FILE)
readonly WP_EMAIL_SMTP_PORT=$(jq -r ".wpEmailSmtp.${APP_BRANCH}.smtpPort" $APP_CONFIG_FILE)
readonly WP_EMAIL_SMTP_USERNAME=$(jq -r ".wpEmailSmtp.${APP_BRANCH}.smtpUsername" $APP_CONFIG_FILE)
readonly WP_EMAIL_SMTP_PASSWORD=$(jq -r ".wpEmailSmtp.${APP_BRANCH}.smtpPassword" $APP_CONFIG_FILE)

readonly WP_EMAIL_SMTP_FROM_EMAIL_CHAR_COUNT=${#WP_EMAIL_SMTP_FROM_EMAIL}
readonly WP_EMAIL_SMTP_FROM_NAME_CHAR_COUNT=${#WP_EMAIL_SMTP_FROM_NAME}
readonly WP_EMAIL_SMTP_HOST_CHAR_COUNT=${#WP_EMAIL_SMTP_HOST}
readonly WP_EMAIL_SMTP_PORT_CHAR_COUNT=${#WP_EMAIL_SMTP_PORT}
readonly WP_EMAIL_SMTP_USERNAME_CHAR_COUNT=${#WP_EMAIL_SMTP_USERNAME}
readonly WP_EMAIL_SMTP_PASSWORD_CHAR_COUNT=${#WP_EMAIL_SMTP_PASSWORD}

# Wordpress upload S3 bucket settings
readonly UPLOAD_S3_BUCKET=$(jq -r ".aws.uploadS3Bucket" $APP_CONFIG_FILE)
readonly UPLOAD_S3_BUCKET_PATH=${APP_NAME}/${APP_BRANCH}/wp-content/uploads

readonly UPLOAD_S3_BUCKET_PATH_CHAR_COUNT=${#UPLOAD_S3_BUCKET_PATH}
readonly UPLOAD_S3_BUCKET_CHAR_COUNT=${#UPLOAD_S3_BUCKET}

# Wordpress site name
readonly WP_SITE_NAME=$(jq -r ".wordpress.siteTitle" $APP_CONFIG_FILE)

# Wordpress tagline
readonly WP_TAGLINE=$(jq -r ".wordpress.tagline" $APP_CONFIG_FILE)

# Wordpress Akismet
readonly WP_API_KEY=$(jq -r ".wordpress.apiKey" $APP_CONFIG_FILE)

# WPS Hide Login
readonly WP_LOGIN_URL=$(jq -r ".wordpress.loginUrl" $APP_CONFIG_FILE)

# Recaptcha
readonly RECAPTCHA_SITE_KEY=$(jq -r ".wordpress.recaptcha.siteKey" $APP_CONFIG_FILE)
readonly RECAPTCHA_SECRET_KEY=$(jq -r ".wordpress.recaptcha.secretKey" $APP_CONFIG_FILE)

# Update Wordpress site name
no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_SITE_NAME}' WHERE option_name = 'blogname';"

# Update Wordpress tagline
no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_TAGLINE}' WHERE option_name = 'blogdescription';"

# Update Wordpress admin info
no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_users SET user_login = '${WP_ADMIN_USERNAME}', user_nicename = '${WP_ADMIN_DISPLAY_NAME}', user_email = '${WP_ADMIN_EMAIL}', display_name = '${WP_ADMIN_DISPLAY_NAME}', user_pass = MD5('${WP_ADMIN_PASSWORD}') WHERE ${DB_DATABASE}.wp_users.ID = 1;"

no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_ADMIN_EMAIL}' WHERE option_name = 'admin_email';"

# Update WP Email Smtp plugin settings
readonly WP_EMAIL_SMTP_OPTION_VALUE="a:10:{s:10:\"from_email\";s:${WP_EMAIL_SMTP_FROM_EMAIL_CHAR_COUNT}:\"${WP_EMAIL_SMTP_FROM_EMAIL}\";s:9:\"from_name\";s:${WP_EMAIL_SMTP_FROM_NAME_CHAR_COUNT}:\"${WP_EMAIL_SMTP_FROM_NAME}\";s:6:\"mailer\";s:4:\"smtp\";s:20:\"mail_set_return_path\";s:4:\"true\";s:9:\"smtp_host\";s:${WP_EMAIL_SMTP_HOST_CHAR_COUNT}:\"${WP_EMAIL_SMTP_HOST}\";s:9:\"smtp_port\";s:${WP_EMAIL_SMTP_PORT_CHAR_COUNT}:\"${WP_EMAIL_SMTP_PORT}\";s:15:\"smtp_encryption\";s:3:\"tls\";s:19:\"smtp_authentication\";s:4:\"true\";s:13:\"smtp_username\";s:${WP_EMAIL_SMTP_USERNAME_CHAR_COUNT}:\"${WP_EMAIL_SMTP_USERNAME}\";s:13:\"smtp_password\";s:${WP_EMAIL_SMTP_PASSWORD_CHAR_COUNT}:\"${WP_EMAIL_SMTP_PASSWORD}\";}"

readonly HAS_WP_EMAIL_SMTP=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'wp_email_smtp_option_name';")

if [ "$HAS_WP_EMAIL_SMTP" == 1 ]; then

  no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_EMAIL_SMTP_OPTION_VALUE}' WHERE option_name = 'wp_email_smtp_option_name';"

else

  no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('wp_email_smtp_option_name', '${WP_EMAIL_SMTP_OPTION_VALUE}', 'yes');"

fi

# Update Offload S3 plugin settings

readonly WP_OFFLOAD_S3_OPTION_VALUE="a:13:{s:6:\"bucket\";s:${UPLOAD_S3_BUCKET_CHAR_COUNT}:\"${UPLOAD_S3_BUCKET}\";s:10:\"cloudfront\";s:0:\"\";s:10:\"copy-to-s3\";s:1:\"1\";s:6:\"domain\";s:4:\"path\";s:20:\"enable-object-prefix\";s:1:\"1\";s:11:\"force-https\";s:1:\"0\";s:13:\"object-prefix\";s:${UPLOAD_S3_BUCKET_PATH_CHAR_COUNT}:\"${UPLOAD_S3_BUCKET_PATH}\";s:17:\"object-versioning\";s:1:\"1\";s:17:\"post_meta_version\";i:6;s:6:\"region\";s:0:\"\";s:17:\"remove-local-file\";s:1:\"0\";s:13:\"serve-from-s3\";s:1:\"1\";s:21:\"use-yearmonth-folders\";s:1:\"1\";}"

readonly HAS_WP_OFFLOAD_S3=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'tantan_wordpress_s3';")

if [ "$HAS_WP_OFFLOAD_S3" == 1 ]; then

  no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_OFFLOAD_S3_OPTION_VALUE}' WHERE option_name = 'tantan_wordpress_s3';"

else

  no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('tantan_wordpress_s3', '${WP_OFFLOAD_S3_OPTION_VALUE}', 'yes');"

fi

# Update Akismet plugin settings

if [ "$WP_API_KEY" != "" ]; then
  readonly HAS_WP_API_KEY=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'wordpress_api_key';")

  if [ "$HAS_WP_API_KEY" == 1 ]; then

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_API_KEY}' WHERE option_name = 'wordpress_api_key';"

  else

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('wordpress_api_key', '${WP_API_KEY}', 'yes');"

  fi

fi

# Update WPS Hide Login settings

if [ "$WP_LOGIN_URL" != "" ]; then

  readonly HAS_LOGIN_URL=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'whl_page';")

  if [ "$HAS_LOGIN_URL" == 1 ]; then

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_LOGIN_URL}' WHERE option_name = 'whl_page';"

  else

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('whl_page', '${WP_LOGIN_URL}', 'yes');"

  fi

fi

# Update Contact Form 7 reCAPTCHA

if [ "$RECAPTCHA_SITE_KEY" != "" ] && [ "$RECAPTCHA_SECRET_KEY" != "" ]; then

  readonly HAS_CF7_RECAPTCHA=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'wpcf7';")

  readonly CF7_RECAPTCHA_VALUE="a:2:{s:7:\"version\";s:5:\"5.0.1\";s:9:\"recaptcha\";a:1:{s:40:\"${RECAPTCHA_SITE_KEY}\";s:40:\"${RECAPTCHA_SECRET_KEY}\";}}"

  if [ "$HAS_CF7_RECAPTCHA" == 1 ]; then

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${CF7_RECAPTCHA_VALUE}' WHERE option_name = 'wpcf7';"

else

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('wpcf7', '${CF7_RECAPTCHA_VALUE}', 'yes');"

  fi

fi

# Activate pre-installed plugins
# SELECT * FROM wp_options WHERE option_name = 'active_plugins';

if [ "$ACTIVATE_PREINSTALLED_PLUGINS" == 1 ]; then

  readonly WP_ACTIVATE_PLUGIN_VALUES="a:12:{i:0;s:19:\"akismet/akismet.php\";i:1;s:41:\"amazon-s3-and-cloudfront/wordpress-s3.php\";i:2;s:60:\"cf7-conditional-fields/contact-form-7-conditional-fields.php\";i:3;s:36:\"contact-form-7/wp-contact-form-7.php\";i:4;s:23:\"elementor/elementor.php\";i:5;s:21:\"flamingo/flamingo.php\";i:6;s:51:\"header-footer-elementor/header-footer-elementor.php\";i:7;s:21:\"megamenu/megamenu.php\";i:8;s:24:\"wordpress-seo/wp-seo.php\";i:9;s:31:\"wp-email-smtp/wp_email_smtp.php\";i:10;s:33:\"wpcf7-redirect/wpcf7-redirect.php\";i:11;s:33:\"wps-hide-login/wps-hide-login.php\";}"
  
  no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_ACTIVATE_PLUGIN_VALUES}' WHERE option_name = 'active_plugins';"

fi
