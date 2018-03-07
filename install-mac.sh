#!/bin/bash

set -x

export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig/lib/pkgconfig:/usr/local/Cellar/qt/5.10.1/lib/pkgconfig:$PKG_CONFIG_PATH

# export LDFLAGS="-g -fsanitize=address -L/usr/local/opt/openssl/lib -L/usr/local/opt/boost@1.60/lib -L/usr/local/opt/qt/lib"

export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/boost@1.60/lib -L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/boost@1.60/include -I/usr/local/opt/qt/include"

export QR_LIBS="/usr/local/opt/qrencode/lib/libqrencode.dylib"
export QR_CFLAGS="-I/usr/local/opt/qrencode/include"

export CXXFLAGS="-std=c++11 -arch x86_64 -Wno-deprecated-declarations"
export OBJCXXFLAGS="-std=c++11 -arch x86_64 -Wno-deprecated-declarations"
# export CXXFLAGS="-std=c++11 -arch x86_64 -Wno-deprecated-declarations -O1 -g -fsanitize=address -fno-omit-frame-pointer"
# export OBJCXXFLAGS="-std=c++11 -arch x86_64 -Wno-deprecated-declarations -O1 -g -fsanitize=address -fno-omit-frame-pointer"

./autogen.sh
./configure --with-gui=qt5 --with-qrencode --enable-upnp-default --enable-shared=no --disable-tests
make -j8 deploy