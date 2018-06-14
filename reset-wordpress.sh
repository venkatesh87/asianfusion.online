#!/bin/bash

source ./variables.sh
source ./functions.sh

ACTIVATE_PREINSTALLED_PLUGINS=0

if [[ $# -eq 1 ]] ; then
  ACTIVATE_PREINSTALLED_PLUGINS=$1
fi

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
readonly UPLOAD_S3_BUCKET=$(jq -r ".aws.wordpressUploadS3Bucket" $APP_CONFIG_FILE)
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

# Enable emoji
readonly WP_ENABLE_EMOJI=$(jq -r ".wordpress.enableEmoji" $APP_CONFIG_FILE)

# Minify HTML
readonly WP_MINIFY_HTML=$(jq -r ".wordpress.${APP_BRANCH}.minifyHtml" $APP_CONFIG_FILE)

# Recaptcha
readonly RECAPTCHA_SITE_KEY=$(jq -r ".wordpress.recaptcha.siteKey" $APP_CONFIG_FILE)
readonly RECAPTCHA_SECRET_KEY=$(jq -r ".wordpress.recaptcha.secretKey" $APP_CONFIG_FILE)

# Wordpress users
# https://starkandwayne.com/blog/bash-for-loop-over-json-array-using-jq/
# -c = compact-output to get each object on a newline
# @base64 to get rid of spaces
readonly WP_USERS=$(jq -c -r ".wordpress.users[] | @base64" $APP_CONFIG_FILE)

# Update Wordpress site name
no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_SITE_NAME}' WHERE option_name = 'blogname';"

# Update Wordpress tagline
no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_TAGLINE}' WHERE option_name = 'blogdescription';"

# Update Wordpress admin info
no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_users SET user_login = '${WP_ADMIN_USERNAME}', user_nicename = '${WP_ADMIN_DISPLAY_NAME}', user_email = '${WP_ADMIN_EMAIL}', display_name = '${WP_ADMIN_DISPLAY_NAME}', user_pass = MD5('${WP_ADMIN_PASSWORD}') WHERE ${DB_DATABASE}.wp_users.ID = 1;"

no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_ADMIN_EMAIL}' WHERE option_name = 'admin_email';"

# Update WP Email Smtp plugin settings

if [ "$WP_EMAIL_SMTP_FROM_EMAIL" != "" ] && [ "$WP_EMAIL_SMTP_FROM_NAME" != "" ] && [ "$WP_EMAIL_SMTP_HOST" != "" ] && [ "$WP_EMAIL_SMTP_PORT" != "" ] && [ "$WP_EMAIL_SMTP_USERNAME" != "" ] && [ "$WP_EMAIL_SMTP_PASSWORD" != "" ]; then

  readonly WP_EMAIL_SMTP_OPTION_VALUE="a:10:{s:10:\"from_email\";s:${WP_EMAIL_SMTP_FROM_EMAIL_CHAR_COUNT}:\"${WP_EMAIL_SMTP_FROM_EMAIL}\";s:9:\"from_name\";s:${WP_EMAIL_SMTP_FROM_NAME_CHAR_COUNT}:\"${WP_EMAIL_SMTP_FROM_NAME}\";s:6:\"mailer\";s:4:\"smtp\";s:20:\"mail_set_return_path\";s:4:\"true\";s:9:\"smtp_host\";s:${WP_EMAIL_SMTP_HOST_CHAR_COUNT}:\"${WP_EMAIL_SMTP_HOST}\";s:9:\"smtp_port\";s:${WP_EMAIL_SMTP_PORT_CHAR_COUNT}:\"${WP_EMAIL_SMTP_PORT}\";s:15:\"smtp_encryption\";s:3:\"tls\";s:19:\"smtp_authentication\";s:4:\"true\";s:13:\"smtp_username\";s:${WP_EMAIL_SMTP_USERNAME_CHAR_COUNT}:\"${WP_EMAIL_SMTP_USERNAME}\";s:13:\"smtp_password\";s:${WP_EMAIL_SMTP_PASSWORD_CHAR_COUNT}:\"${WP_EMAIL_SMTP_PASSWORD}\";}"

  readonly HAS_WP_EMAIL_SMTP=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'wp_email_smtp_option_name';")

  if [ "$HAS_WP_EMAIL_SMTP" == 1 ]; then

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_EMAIL_SMTP_OPTION_VALUE}' WHERE option_name = 'wp_email_smtp_option_name';"

  else

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('wp_email_smtp_option_name', '${WP_EMAIL_SMTP_OPTION_VALUE}', 'yes');"

  fi

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

# Update enable emoji setting

if [ "$WP_ENABLE_EMOJI" != "" ]; then

  readonly HAS_ENABLE_EMOJI=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'enable_emoji';")

  if [ "$HAS_ENABLE_EMOJI" == 1 ]; then

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_ENABLE_EMOJI}' WHERE option_name = 'enable_emoji';"

  else

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('enable_emoji', '${WP_ENABLE_EMOJI}', 'yes');"

  fi

fi

# Update minify HTML settings

if [ "$WP_MINIFY_HTML" != "" ]; then

  readonly HAS_MINIFY_HTML=$(no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -se "SELECT COUNT(option_id) FROM ${DB_DATABASE}.wp_options WHERE option_name = 'minify_html_active';")

  if [ "$HAS_MINIFY_HTML" == 1 ]; then

    if [ "$WP_MINIFY_HTML" == 1 ]; then
    
      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = 'yes' WHERE option_name = 'minify_html_active';"
    
      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = 'yes' WHERE option_name = 'minify_javascript';"
    
      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = 'yes' WHERE option_name = 'minify_html_comments';"

    else

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = 'no' WHERE option_name = 'minify_html_active';"

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = 'no' WHERE option_name = 'minify_javascript';"
    
      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = 'no' WHERE option_name = 'minify_html_comments';"

    fi

  else

    if [ "$WP_MINIFY_HTML" == 1 ]; then

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('minify_html_active', 'yes', 'yes');"

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('minify_javascript', 'yes', 'yes');"

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('minify_html_comments', 'yes', 'yes');"

    else

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('minify_html_active', 'no', 'yes');"

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('minify_javascript', 'no', 'yes');"

      no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_options (option_name, option_value, autoload) VALUES ('minify_html_comments', 'no', 'yes');"

    fi

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

for USER in $WP_USERS; do

  USERNAME=$(echo $USER | base64 --decode | jq -r ".username")
  
  if [ "$USERNAME" != "" ]; then

    PASSWORD=$(echo $USER | base64 --decode | jq -r ".password")
    EMAIL=$(echo $USER | base64 --decode | jq -r ".email")
    ROLE=$(echo $USER | base64 --decode | jq -r ".role")
    ROLE_COUNT=${#ROLE}
    USER_NICENAME=$(echo $USER | base64 --decode | jq -r ".userNicename")
    DISPLAY_NAME=$(echo $USER | base64 --decode | jq -r ".displayName")

    no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "INSERT INTO ${DB_DATABASE}.wp_users (user_login, user_pass, user_nicename, display_name, user_email, user_status) VALUES ('${USERNAME}', MD5('${PASSWORD}'), '${USER_NICENAME}', '${DISPLAY_NAME}', '${EMAIL}', '0'); INSERT INTO ${DB_DATABASE}.wp_usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, (SELECT id FROM ${DB_DATABASE}.wp_users WHERE user_login = '${USERNAME}'), 'wp_capabilities', 'a:1:{s:${ROLE_COUNT}:\"${ROLE}\";b:1;}'); INSERT INTO ${DB_DATABASE}.wp_usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, (SELECT id FROM ${DB_DATABASE}.wp_users WHERE user_login = '${USERNAME}'), 'wp_user_level', '10');"
  
  fi

done

# Activate pre-installed plugins
# SELECT * FROM wp_options WHERE option_name = 'active_plugins';

if [ "$ACTIVATE_PREINSTALLED_PLUGINS" == 1 ]; then

  readonly WP_ACTIVATE_PLUGIN_VALUES="a:18:{i:0;s:30:\"advanced-custom-fields/acf.php\";i:1;s:19:\"akismet/akismet.php\";i:2;s:41:\"amazon-s3-and-cloudfront/wordpress-s3.php\";i:3;s:27:\"astra-sites/astra-sites.php\";i:4;s:60:\"cf7-conditional-fields/contact-form-7-conditional-fields.php\";i:5;s:36:\"contact-form-7/wp-contact-form-7.php\";i:6;s:43:\"custom-post-type-ui/custom-post-type-ui.php\";i:7;s:23:\"elementor/elementor.php\";i:8;s:32:\"emoji-settings/emojisettings.php\";i:9;s:21:\"flamingo/flamingo.php\";i:10;s:43:\"google-analytics-dashboard-for-wp/gadwp.php\";i:11;s:34:\"minify-html-markup/minify-html.php\";i:12;s:48:\"simple-301-redirects/wp-simple-301-redirects.php\";i:13;s:41:\"wordpress-importer/wordpress-importer.php\";i:14;s:24:\"wordpress-seo/wp-seo.php\";i:15;s:31:\"wp-email-smtp/wp_email_smtp.php\";i:16;s:33:\"wpcf7-redirect/wpcf7-redirect.php\";i:17;s:33:\"wps-hide-login/wps-hide-login.php\";}"
  
  no_pw_warning mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "UPDATE ${DB_DATABASE}.wp_options SET option_value = '${WP_ACTIVATE_PLUGIN_VALUES}' WHERE option_name = 'active_plugins';"

fi

echo Resetting WordPress plugins and configurations
