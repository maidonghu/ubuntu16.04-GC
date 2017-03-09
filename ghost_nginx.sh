#!/bin/bash

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs unzip

sudo mkdir -p /var/www/
cd /var/www/
sudo wget https://ghost.org/zip/ghost-latest.zip
sudo unzip -d ghost ghost-latest.zip

