#!/bin/bash
sleep 60
apt-get --assume-yes install apt-transport-https ca-certificates
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get --assume-yes update
apt-get --assume-yes upgrade
apt-get --assume-yes install mongodb-org
systemctl start mongod
systemctl enable mongod
