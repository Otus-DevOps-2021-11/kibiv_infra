#!/bin/bash
# Install Ruby
apt update
apt install -y ruby-full ruby-bundler build-essential wget git 
# Check Ruby
ruby -v
bundler -v
# Preinstall MongoDB
 wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
 echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
# Install MongoDB
 apt update
 apt-get install -y mongodb-org
# Start service MongoDB
 systemctl start mongod
 systemctl enable mongod
# Check status service MongoDB
systemctl status mongod
# Check Ruby
pwd
cd /home/yc-user
git clone -b monolith https://github.com/express42/reddit.git 
cd reddit && bundle install
# Deploy App
puma -d
ps aux | grep puma

