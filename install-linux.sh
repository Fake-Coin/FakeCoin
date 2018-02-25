#!/bin/bash

sudo apt-get install build-essential libtool autotools-dev autoconf pkg-config libevent-dev

# OpenSSL
sudo apt-get install openssl libssl-dev

# Boost
sudo apt-get install libboost-all-dev

# Qt
sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools

# Protocol Buffers
sudo apt-get install libprotobuf-dev protobuf-compiler

# QR Codes
sudo apt-get install libqrencode-dev

# UPnP
sudo apt-get install libminiupnpc-dev

# Berkeley DB
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev

./autogen.sh 
./configure 
make -j8 deploy