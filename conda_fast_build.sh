#!/bin/bash
set -x
set -e

# Install conda
export MINICONDA_PYVER="2"
./bin/conda-inst.sh

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

# install deps
conda install nose pytables hdf5 scipy cython cmake

#install MOAB
cd moab-4.6.3
./configure --prefix="${condir}" --enable-shared --with-hdf5="${condir}"
make
make install
cd ..

# Install PyTAPS
cd PyTAPS-1.4
python setup.py build
python setup.py install --skip-build --prefix="${condir}"
cd ..

# Install PyNE
cd pyne
python setup.py install --prefix="${condir}" --hdf5="${condir}" -- \
  -DMOAB_INCLUDE_DIR="${condir}/include" -DMOAB_LIBRARY="${condir}/lib"
cd scripts
env
nuc_data_make
cd ../..
