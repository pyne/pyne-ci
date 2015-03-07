#!/bin/bash
set -e

unset LDFLAGS
export LD_LIBRARY_PATH="$PREFIX/lib"
export CMAKE_LIBRARY_PATH="$PREFIX/lib"
export PATH="$PREFIX/bin:$PATH"
export DYLD_FALLBACK_LIBRARY_PATH="$PREFIX/lib/cyclus:$PREFIX/lib"
UNAME=$(uname)

if [[ "${UNAME}" == 'Linux' ]]; then
  ln -s $PREFIX/lib/libhdf5.so.9 $PREFIX/lib/libhdf5.so.8
  ln -s $PREFIX/lib/libhdf5_hl.so.9 $PREFIX/lib/libhdf5_hl.so.8
else
  ln -s $PREFIX/lib/libhdf5.9.dylib $PREFIX/lib/libhdf5.8.dylib
  ln -s $PREFIX/lib/libhdf5_hl.9.dylib $PREFIX/lib/libhdf5_hl.8.dylib
  export CC=gcc
  export CXX=g++
fi

${PYTHON} setup.py install
nuc_data_make

#
# Annoying hack for copying dlls
#
if [[ "$OSTYPE" == "darwin"* ]]; then
  cp build/src/*.dylib $PREFIX/lib
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  find . -name '*.so' | xargs chmod +x
  cp build/src/*.so $PREFIX/lib
fi
