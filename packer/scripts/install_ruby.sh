#!/bin/bash
apt-get --assume-yes update
#delay for cheap slow vm's
sleep 10
apt-get --assume-yes install ruby-full ruby-bundler build-essential
