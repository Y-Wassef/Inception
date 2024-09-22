#!/bin/sh

WP_DIR="/var/www/html"

# Check for required environment variables
if [ -z "$MYSQL_USER" ]; then echo "Error : MYSQL_USER is undefined"; exit 1; fi
if [ -z "$MYSQL_PASSWORD" ]; then echo "Error : MYSQL_PASSWORD is undefined"; exit 1; fi
if [ -z "$MYSQL_HOSTNAME" ]; then echo "Error : MYSQL_HOSTNAME is undefined"; exit 1; fi
if [ -z "$MYSQL_DATABASE" ]; then echo "Error : MYSQL_DATABASE is undefined"; exit 1; fi
if [ -z "$WORDPRESS_URL" ]; then echo "Error : WORDPRESS_URL is undefined"; exit 1; fi
if [ -z "$WORDPRESS_TITLE" ]; then echo "Error : WORDPRESS_TITLE is undefined"; exit 1; fi
if [ -z "$WORDPRESS_ADMIN_USER" ]; then echo "Error : WORDPRESS_ADMIN_USER is undefined"; exit 1; fi
if [ -z "$WORDPRESS_ADMIN_PASSWORD" ]; then echo "Error : WORDPRESS_ADMIN_PASSWORD is undefined"; exit 1; fi
if [ -z "$WORDPRESS_ADMIN_EMAIL" ]; then echo "Error : WORDPRESS_ADMIN_EMAIL is undefined"; exit 1; fi
if [ -z "$WORDPRESS_DB_USER" ]; then echo "Error : WORDPRESS_DB_USER is undefined"; exit 1; fi
if [ -z "$WORDPRESS_USER_EMAIL" ]; then echo "Error : WORDPRESS_USER_EMAIL is undefined"; exit 1; fi
if [ -z "$WORDPRESS_USER_PASSWORD" ]; then echo "Error : WORDPRESS_USER_PASSWORD is undefined"; exit 1; fi

# Ensure the /run/php directory exists
mkdir -p /run/php

if [ -f "$WP_DIR/wp-config.php" ]; then
    echo "Removing existing WordPress files"
    rm -rf $WP_DIR/*
fi

echo "Downloading and extracting WordPress..."
wget http://wordpress.org/latest.zip -O /tmp/latest.zip && \
unzip /tmp/latest.zip -d /var/www/ && \
mv /var/www/wordpress/* $WP_DIR/ && \
rmdir /var/www/wordpress && \
rm /tmp/latest.zip
echo "WordPress has been downloaded and extracted."

# Import env variables into the config file
sed -i "s/username_here/$MYSQL_USER/g" $WP_DIR/wp-config-sample.php
sed -i "s/password_here/$MYSQL_PASSWORD/g" $WP_DIR/wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOSTNAME/g" $WP_DIR/wp-config-sample.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g" $WP_DIR/wp-config-sample.php
cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php
echo "WordPress configuration file has been set up."

echo "Setting up users..."
wp core install --allow-root --url="$WORDPRESS_URL" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL"
wp user create --allow-root "$WORDPRESS_DB_USER" "$WORDPRESS_USER_EMAIL" --user_pass="$WORDPRESS_USER_PASSWORD"
echo "WordPress: set up!"

php-fpm7.4 --nodaemonize
