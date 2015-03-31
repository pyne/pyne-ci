#!/bin/bash

autoreconf -fi
./configure --with-hdf5=$PREFIX --prefix=$PREFIX --without-cgm \
  --enable-optimize --disable-debug --enable-shared --with-pic --enable-tools
make
make install
