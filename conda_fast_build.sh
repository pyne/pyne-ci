#!/bin/bash
set -x
set -e

# Install conda
export MINICONDA_PYVER="2"
./bin/conda-inst.sh
source conda_env.sh

# install deps
conda install nose pytables hdf5 scipy cython cmake

#install MOAB
cd moab-4.6.3
./configure --prefix="${CONDIR}" --enable-shared --with-hdf5="${CONDIR}"
make
make install
cd ..

# Install PyTAPS
cd PyTAPS-1.4
python setup.py build
python setup.py install --skip-build --prefix="${CONDIR}"
cd ..

# Install PyNE
cd pyne
python setup.py install --build-type=debug --prefix="${CONDIR}" --hdf5="${CONDIR}" -- \
  -DMOAB_INCLUDE_DIR="${CONDIR}/include" -DMOAB_LIBRARY="${CONDIR}/lib"
cd scripts
env
nuc_data_make
cd ../..
