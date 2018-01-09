#!/bin/bash

set -x

brew install openssl boost@1.60 berkeley-db@4 miniupnpc qt qrencode

export BOOST_PATH=`brew --prefix boost@1.60`
export BDB_PATH=`brew --prefix berkeley-db@4`
export OPENSSL_PATH=`brew --prefix openssl`
export MINIUPNPC_PATH=`brew --prefix miniupnpc`

/usr/local/opt/qt/bin/qmake RELEASE=1 USE_UPNP=1 USE_QRCODE=1 \
	BOOST_INCLUDE_PATH=$BOOST_PATH/include \
	BOOST_LIB_PATH=$BOOST_PATH/lib \
	BDB_INCLUDE_PATH=$BDB_PATH/include \
	BDB_LIB_PATH=$BDB_PATH/lib \
	OPENSSL_INCLUDE_PATH=$OPENSSL_PATH/include \
	OPENSSL_LIB_PATH=$OPENSSL_PATH/lib \
	MINIUPNPC_INCLUDE_PATH=$MINIUPNPC_PATH/include \
	MINIUPNPC_LIB_PATH=$MINIUPNPC_PATH/lib

make -j8

## Release Builds (creates portable .app and dmg)
#export QTDIR=`brew --prefix qt`
#T=$(contrib/qt_translations.py $QTDIR/translations src/qt/locale)
#python2.7 share/qt/clean_mac_info_plist.py
#python2.7 contrib/macdeploy/macdeployqtplus FakeCoin-Qt.app -add-qt-tr $T -dmg -fancy contrib/macdeploy/fancy.plist
