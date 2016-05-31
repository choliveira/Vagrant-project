#!/usr/bin/env bash
apt-get update

# install git
apt-get install -y git
#install unzip
apt-get install unzip
# install apapche
apt-get install -y apache2

a2enmod rewrite
a2enmod headers
a2enmod deflate
service apache2 reload

# set up virtual host
cp $3/ServerProvision/project_name.local.conf /etc/apache2/sites-available/project_name.local.conf
a2ensite project_name.local

a2dissite 000-default.conf

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server mysql-server/root_password password $1" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $1" | debconf-set-selections
apt-get -y install mysql-server
# secure mysql
apt-get install -y expect

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$1\r\"

expect \"Change the root password?\"
send \"n\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

echo "$SECURE_MYSQL"

add-apt-repository -y ppa:ondrej/php
apt-get update
# Install PH
apt-get -y install php7.0 php7.0-xml php7.0-mbstring libapache2-mod-php7.0 php7.0-curl php7.0-gd php7.0-json php7.0-dev
apt-get -y install php7.0-mysql

# set php timezone
sed -i "/date.timezone =/ c\date.timezone = \"$2\"" /etc/php/7.0/cli/php.ini /etc/php/7.0/apache2/php.ini
service apache2 restart

# composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
