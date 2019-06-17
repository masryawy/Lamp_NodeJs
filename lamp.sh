#!/bin/sh

#######################################
# Bash script to install an AMP stack and PHPMyAdmin plus tweaks. For Debian based systems.
# Written by @masryawy from https://aait.sa

# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
# Update packages and Upgrade system
echo -e "$Cyan \n install Some Package.. $Color_Off"
sudo apt-get update -y && sudo apt-get install screen wget nano curl -y
# Update packages and Upgrade system
echo -e "$Red \n Updating System.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

## Install AMP
echo -e "$Purple \n Installing Apache2 $Color_Off"
sudo apt-get install apache2 apache2-doc apache2-utils libexpat1 ssl-cert -y
echo -e "$Green \n Installing Old Repository $Color_Off"
sudo apt install software-properties-common -y && sudo add-apt-repository ppa:ondrej/php -y && sudo apt-get update -y
echo -e "$Cyan \n Installing PHP & Requirements $Color_Off"
sudo apt-get install php7.1 php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip php7.1-fpm php7.1-intl php7.1-simplexml libapache2-mod-php7.1 -y

echo -e "$Yellow \n Installing MySQL $Color_Off"
sudo apt-get install mysql-server mysql-client libmysqlclient15.dev -y

echo -e "$Red \n Installing phpMyAdmin $Color_Off"
sudo apt-get install phpmyadmin -y

echo -e "$Purple \n Installing Nodejs $Color_Off"
sudo apt install nodejs -y && sudo apt install npm -y

echo -e "$Green \n Verifying installs$Color_Off"
sudo apt-get install apache2 libapache2-mod-php7.1 php7.1 mysql-server php-pear php7.1-mysql mysql-client mysql-server php7.1-mysql php7.1-gd -y

## TWEAKS and Settings
# Permissions
echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo -e "$Red \n Enabling Modules $Color_Off"
sudo a2enmod rewrite
sudo phpenmod mcrypt

# Restart Apache
echo -e "$Purple \n Restarting Apache $Color_Off"
sudo service apache2 restart
npm i -g forever
