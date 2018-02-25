#!/bin/bash

set -x

brew install autoconf automake libtool pkg-config
brew install openssl boost@1.60 berkeley-db@4 protobuf@2.6 miniupnpc qt qrencode

export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig/lib/pkgconfig:/usr/local/Cellar/qt/5.10.1/lib/pkgconfig:$PKG_CONFIG_PATH

export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/boost@1.60/lib -L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/boost@1.60/include -I/usr/local/opt/qt/include"

export QR_LIBS="/usr/local/opt/qrencode/lib/libqrencode.dylib"
export QR_CFLAGS="-I/usr/local/opt/qrencode/include"

export CXXFLAGS="-std=c++11 -arch x86_64 -Wno-deprecated-declarations"
export OBJCXXFLAGS="-std=c++11 -arch x86_64 -Wno-deprecated-declarations"

./autogen.sh
./configure --with-gui=qt5 --with-qrencode --enable-upnp-default --enable-shared=no --disable-tests
make -j8 deploy
