#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# Update Debian10 and install needed packages
apt update && apt upgrade -y
apt install apache2 -y

# Install required php dependencies
apt install -y php libapache2-mod-php php-mysql php-mbstring php-gd php-pdo php-xml php-cli php-curl php-http php-json

# Extract web app from the shared vagrant folder
tar -xjvf /vagrant/dtapiapp.tar.bz2 -C /var/www/

# Set $USER as an owner of web app directory
chown -R vagrant:vagrant /var/www/dtapi

# Create directories cache, logs and modify permissions to enable them in web app
mkdir /var/www/dtapi/api/application/cache /var/www/dtapi/api/application/logs
chmod 733 /var/www/dtapi/api/application/cache
chmod 722 /var/www/dtapi/api/application/logs

# Set Apache VirtualHost for web app
cat <<'EOF' > /etc/apache2/sites-available/dtapi.conf
<VirtualHost *:80>
#    ServerName your_domain
#    ServerAlias www.your_domain
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/dtapi
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
<Directory /var/www/dtapi>
	AllowOverride All
</Directory>
EOF

# Enable web app in Apache, disable default Apache website directory
a2ensite dtapi
a2dissite 000-default
# Enable Apache modules (headers and rewrite)
a2enmod headers
a2enmod rewrite

# Restart Apache to enable new config
systemctl restart apache2
