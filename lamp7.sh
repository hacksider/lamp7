#!/bin/sh

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Update packages and Upgrade system 1
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/php

# Update packages and Upgrade system
echo -e "$Cyan \n Updating System.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

## Install AMP
echo -e "$Cyan \n Installing Apache2 $Color_Off"
sudo apt-get install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y

echo -e "$Cyan \n Installing PHP & Requirements $Color_Off"
sudo apt-get install python-software-properties php7.1 php7.1-xml php7.1-xmlrpc php7.1-zip php7.1-opcache php7.1-xsl php7.1-gd php7.1-gmp php7.1-curl php7.1-common -y

echo -e "$Cyan \n Installing MariaDB $Color_Off"
sudo apt-get install mariadb-server mariadb -y

echo -e "$Cyan \n Enabling MariaDB $Color_Off"
systemctl start mariadb.service
systemctl enable mariadb.service

echo -e "$Cyan \n Installing phpMyAdmin $Color_Off"
sudo apt-get install phpmyadmin -y


## TWEAKS and Settings
# Permissions
echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo -e "$Cyan \n Enabling Modules $Color_Off"
sudo a2enmod rewrite
sudo php7enmod mcrypt

# Restart Apache
echo -e "$Cyan \n Restarting Apache $Color_Off"
sudo service apache2 restart
