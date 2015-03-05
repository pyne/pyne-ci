#!/bin/bash
unset LDFLAGS
export PATH="${PREFIX}/bin:${PATH}"

${PYTHON} setup.py install || exit 1;
nuc_data_make

if [[ "$OSTYPE" == "darwin"* ]]; then
    cp build/pyne/lib/*.dylib $PREFIX/lib
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    find . -name '*.so' | xargs chmod +x
    cp build/pyne/lib/*.so $PREFIX/lib
fi

