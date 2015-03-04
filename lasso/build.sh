#!/bin/bash

autoreconf -fi
./configure --prefix=$PREFIX --enable-optimize --disable-debug \
            --enable-shared --with-igeom=$PREFIX --with-imesh=$PREFIX
make
make install
