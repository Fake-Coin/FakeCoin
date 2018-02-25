# Windows CrossCompile on Linux

[MXE](http://mxe.cc/) is a set of makefiles allowing you compile FakeCoin cross environment with the needed packages (mingw-w64, qt, boost, etc) without pain.

### Creating the cross compile environment

First install the MXE Dependencies: 

```
sudo apt-get install p7zip-full autoconf automake autopoint bash bison bzip2 cmake flex gettext git g++ gperf intltool libffi-dev libtool libltdl-dev libssl-dev libxml-parser-perl make openssl patch perl pkg-config python ruby scons sed unzip wget xz-utils
```

On 64bit Ubuntu also install:

```
sudo apt-get install g++-multilib libc6-dev-i386
```

Next clone the MXE git repo (always clone the repo, downloading the archive may not work):

```
cd /mnt
git clone https://github.com/mxe/mxe.git
```

Your environment will be placed in `/mnt/mxe`

Now we need compile boost and Qt4 for our environment (need a couple of hours for this)
*NOTE: If you compile something using mxe and move mxe directory to another place, then mxe will not work because all what you compile linked statically*
*Compiling boost will fail if memory of your PC less then 2GB. Making swap partition will fix this.*

Compile boost:

```
cd /mnt/mxe
make MXE_TARGETS="i686-w64-mingw32.static" boost
```

Compile Qt4:

```
make MXE_TARGETS="i686-w64-mingw32.static" qt
```

MXE will automatically determine all dependencies and compile it.

Unfortunately MXE does not support berkeley db and miniupnpc so we need compile them manually.

Download and unpack berkley db:

```
cd /mnt
wget http://download.oracle.com/berkeley-db/db-5.3.28.tar.gz
tar zxvf db-5.3.28.tar.gz
```

Make bash script for compilation:

```
cd /mnt/db-5.3.28
touch compile-db.sh
chmod ugo+x compile-db.sh
```

Content of compile-db.sh:

```
#!/bin/bash
MXE_PATH=/mnt/mxe
sed -i "s/WinIoCtl.h/winioctl.h/g" src/dbinc/win_db.h
mkdir build_mxe
cd build_mxe

CC=$MXE_PATH/usr/bin/i686-w64-mingw32.static-gcc \
CXX=$MXE_PATH/usr/bin/i686-w64-mingw32.static-g++ \
../dist/configure \
	--disable-replication \
	--enable-mingw \
	--enable-cxx \
	--host x86 \
	--prefix=$MXE_PATH/usr/i686-w64-mingw32.static

make

make install
```

Compile berkley db:

```
./compile-db.sh
```

Download and unpack miniupnpc:

```
cd /mnt
wget http://miniupnp.free.fr/files/miniupnpc-1.6.20120509.tar.gz
tar zxvf miniupnpc-1.6.20120509.tar.gz
```

Make bash script for compilation:

```
cd /mnt/miniupnpc-1.6.20120509
touch compile-m.sh
chmod ugo+x compile-m.sh
```

Content of compile-m.sh:

```
#!/bin/bash
MXE_PATH=/mnt/mxe

CC=$MXE_PATH/usr/bin/i686-w64-mingw32.static-gcc \
AR=$MXE_PATH/usr/bin/i686-w64-mingw32.static-ar \
CFLAGS="-DSTATICLIB -I$MXE_PATH/usr/i686-w64-mingw32.static/include" \
LDFLAGS="-L$MXE_PATH/usr/i686-w64-mingw32.static/lib" \
make libminiupnpc.a

mkdir $MXE_PATH/usr/i686-w64-mingw32.static/include/miniupnpc
cp *.h $MXE_PATH/usr/i686-w64-mingw32.static/include/miniupnpc
cp libminiupnpc.a $MXE_PATH/usr/i686-w64-mingw32.static/lib
```

Compile miniupnpc:

```
./compile-m.sh
```

Next we need to download Valken's libraries to finish our build environment:

```
mkdir /mnt/q
cd /mnt/q
wget https://download.fakco.in/libs/prebuilt/i686-w64-mingw32-static.zip
unzip i686-w64-mingw32-static.zip
```

Finally we need to add the MXE bins to PATH:

```
export PATH=/mnt/mxe/usr/bin:$PATH
```

And now that we have MXE and Valken's Prebuilt Libraries we can go on to building FakeCoin! 

### Building FakeCoin-qt.exe

Clone the most current version of the FakeCoin sourcecode:

```
cd /mnt
git clone https://github.com/Fake-Coin/FakeCoin-qt.git
```

Compile FakeCoin-qt.exe

```
cd /mnt/FakeCoin-qt
sudo ./mxe.sh
```

The ready to run binary will output to `/mnt/FakeCoin-qt/release/FakeCoin-qt.exe`

Now just move the file to windows, run, and get FAKed!