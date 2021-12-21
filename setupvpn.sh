cat <<EOF> setupvpn.sh
#!/bin/bash
# MongoDB
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.4.list
# Pritunl Server
echo "deb http://repo.pritunl.com/stable/apt focal main" | tee /etc/apt/sources.list.d/pritunl.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
# Install Software
apt-get --assume-yes  update
apt-get --assume-yes  upgrade
apt-get --assume-yes  install curl wget unzip mongodb-server pritunl
systemctl start mongodb
systemctl enable mongodb
systemctl start pritunl mongod
systemctl enable pritunl mongod
EOF

