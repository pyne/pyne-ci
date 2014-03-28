#!/bin/bash

autoreconf -fi
./configure --with-cubit=$PREFIX/cubit/13.2 --prefix=$PREFIX --enable-optimize --disable-debug --enable-shared
make -j 8
make install
