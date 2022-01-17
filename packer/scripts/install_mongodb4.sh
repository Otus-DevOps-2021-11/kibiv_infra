#!/bin/bash
# Preinstall MongoDB
 wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
 echo "deb http://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
# Install MongoDB
 apt-get update
 apt install -y mongodb-org
# Start service MongoDB
 systemctl start mongod
 systemctl enable mongod
