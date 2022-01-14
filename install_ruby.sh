#!/bin/bash
# Install Ruby
apt update
apt install -y ruby-full ruby-bundler build-essential
# Check Ruby
ruby -v
## ruby 2.3.1p112 (2016-04-26) [x86_64-linux-gnu]
bundler -v
## Bundler version 1.11.2

