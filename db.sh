#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

apt update && apt upgrade -y
apt install mariadb-server wget -y

mariadb -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF

mariadb -u root <<-EOF
CREATE DATABASE dtapi;
GRANT ALL ON dtapi.* TO 'dtapi'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

sed -i.bak '/bind-address/ s/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

wget -q https://dtapi.if.ua/~yurkovskiy/dtapi_full.sql
mariadb -u root dtapi < ./dtapi_full.sql

systemctl restart mysql
