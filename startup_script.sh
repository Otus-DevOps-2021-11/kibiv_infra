#!/bin/bash
# Install Ruby
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential wget git 
# Check Ruby
ruby -v
bundler -v
# Preinstall MongoDB
 wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
 echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
# Install MongoDB
sudo  apt update
sudo  apt install -y mongodb-org
# Start service MongoDB
sudo  systemctl start mongod
sudo  systemctl enable mongod
cd /home/yc-user
git clone -b monolith https://github.com/express42/reddit.git 
cd reddit && bundle install
# Deploy App
puma -d
ps aux | grep puma

