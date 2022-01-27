#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

APP_DIR=/opt/reddit

sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit "$APP_DIR"
cd "$APP_DIR"
sudo bundle update --bundler
bundle install

sudo systemctl enable reddit-app
sudo systemctl start reddit-app