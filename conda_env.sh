#!/bin/bash
set -x
set -e

# setup env
condir="$(pwd)/anaconda"
export PATH="${condir}/bin:${condir}/usr/local/bin:${PATH}"
export LD_LIBRARY_PATH="${condir}/lib:$LD_LIBRARY_PATH"
export DYLD_FALLBACK_LIBRARY_PATH="${condir}/lib:$DYLD_FALLBACK_LIBRARY_PATH"
export DYLD_LIBRARY_PATH="${condir}/lib:$DYLD_LIBRARY_PATH"
export C_INCLUDE_PATH="${condir}/include:$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH="${condir}/include:$CPLUS_INCLUDE_PATH"
export LIBRARY_PATH="${condir}/lib:$LIBRARY_PATH"
export HDF5_ROOT="${condir}"
export CONDIR="${condir}"
