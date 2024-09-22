#!/bin/sh

# Check for required environment variables
if [ -z "$WORDPRESS_DB_NAME" ]; then echo "Error : WORDPRESS_DB_NAME is undefined"; exit 1; fi
if [ -z "$WORDPRESS_DB_USER" ]; then echo "Error : WORDPRESS_DB_USER is undefined"; exit 1; fi
if [ -z "$WORDPRESS_USER_PASSWORD" ]; then echo "Error : WORDPRESS_USER_PASSWORD is undefined"; exit 1; fi
if [ -z "$WORDPRESS_ROOT_PASSWORD" ]; then echo "Error : WORDPRESS_ADMIN_PASSWORD is undefined"; exit 1; fi


# Initialize MariaDB 
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB in bootstrap mode
mariadbd --user=mysql --bootstrap <<EOF
USE mysql;
FLUSH PRIVILEGES;

# Remove default user and database
DROP USER IF EXISTS ''@'localhost';
DROP DATABASE IF EXISTS test;

# Create Wordpress database and the user
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%';

# Change root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '$WORDPRESS_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

# Execute MariaDB
exec mariadbd

