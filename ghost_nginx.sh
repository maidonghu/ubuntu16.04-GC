#!/bin/bash

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs unzip

sudo mkdir -p /var/www/
cd /var/www/
sudo wget https://ghost.org/zip/ghost-latest.zip
sudo unzip -d ghost ghost-latest.zip

wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-GC/master/ghost_config.js
sudo mv ghost_config.js config.js

nginx=stable
echo -e "\r" | sudo add-apt-repository ppa:nginx/$nginx
sudo apt-get update
sudo apt-get install -y nginx
cd /etc/nginx/
sudo rm sites-enabled/default
wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-GC/master/ghost
sudo mv ghost  /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/ghost
wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-GC/master/nginx.conf
sudo mv nginx.conf /etc/nginx/

useradd ghost
mkdir -p /home/ghost
chown -R ghost:ghost /home/ghost

su -c "cd /var/www/ghost; npm install forever" ghost
su -c "cd /var/www/ghost; NODE_ENV=production /var/www/ghost/node_modules/forever/bin/forever start index.js" ghost

sudo service nginx restart
