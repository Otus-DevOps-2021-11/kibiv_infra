#!/bin/bash
# Install Software
apt update
apt install -y git
# Check Ruby
pwd
git clone -b monolith https://github.com/express42/reddit.git 
cd reddit && bundle install
# Deploy App
puma -d
ps aux | grep puma

