#!/bin/sh

apt update && apt upgrade -y
apt install apache2 -y

#Install required php dependencies:
apt install -y php libapache2-mod-php php-mysql php-mbstring php-gd php-pdo php-xml php-cli php-curl php-http php-json

#Extract app from the shared vagrant folder:
tar -xjvf /vagrant/dtapiapp.tar.bz2 -C /var/www/

chown -R vagrant:vagrant /var/www/dtapi

mkdir /var/www/dtapi/api/application/cache /var/www/dtapi/api/application/logs
chmod 733 /var/www/dtapi/api/application/cache
chmod 722 /var/www/dtapi/api/application/logs

cat <<EOF > /etc/apache2/sites-available/dtapi.conf
<VirtualHost *:80>
#    ServerName your_domain
#    ServerAlias www.your_domain
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/dtapi
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
<Directory /var/www/dtapi>
	AllowOverride All
</Directory>
EOF

a2ensite dtapi
a2dissite 000-default
a2enmod headers
a2enmod rewrite

systemctl restart apache2
