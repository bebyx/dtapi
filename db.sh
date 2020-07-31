#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# Update Debian10 and install needed packages
apt update && apt upgrade -y
apt install mariadb-server wget -y

# Run mysql_secure_installation script
mariadb -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF

# Create web app database and asign user
mariadb -u root <<-EOF
CREATE DATABASE dtapi;
GRANT ALL ON dtapi.* TO 'dtapi'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Let database be publicly reachable
sed -i.bak '/bind-address/ s/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Import mysql dump into web app database
wget -q https://dtapi.if.ua/~yurkovskiy/dtapi_full.sql
mariadb -u root dtapi < ./dtapi_full.sql

# Restart mysql service to enable new mysql config
systemctl restart mysql
