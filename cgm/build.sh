#!/bin/bash

autoreconf -fi
./configure --prefix=$PREFIX --enable-optimize --disable-debug --enable-shared
make
make install
