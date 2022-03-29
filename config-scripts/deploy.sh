#!/bin/bash
sudo apt-get --assume-yes update
sudo apt-get --assume-yes install git
cd /home/appuser/
sudo git clone -b monolith https://github.com/express42/reddit.git
cd /home/appuser/reddit && bundle install
puma -d
