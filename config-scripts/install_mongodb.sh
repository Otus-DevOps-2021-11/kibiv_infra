#!/bin/bash
# Preinstall MongoDB
 apt update 
 apt install -y wget
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
q

