#!/bin/bash

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs unzip

mkdir -p /var/www/
cd /var/www/
wget https://ghost.org/zip/ghost-latest.zip
unzip -d ghost ghost-latest.zip

wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-GC/master/ghost_config.js
mv ghost_config.js config.js

nginx=stable
echo -e "\r" | add-apt-repository ppa:nginx/$nginx
apt-get update
apt-get install -y nginx
cd /etc/nginx/
rm sites-enabled/default
cd ~
wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-GC/master/ghost
mv ghost  /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/ghost
wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-GC/master/nginx.conf
mv nginx.conf /etc/nginx/

useradd ghost
mkdir -p /home/ghost
chown -R ghost:ghost /home/ghost
chown -R ghost:ghost /var/www/ghost

su -c "cd /var/www/ghost; npm install --production" ghost
su -c "cd /var/www/ghost; npm install forever" ghost
su -c "cd /var/www/ghost; NODE_ENV=production /var/www/ghost/node_modules/forever/bin/forever start index.js" ghost

service nginx restart
