#!/bin/bash
set -x
set -e

# Install conda
export MINICONDA_PYVER="3"
./bin/conda-inst.sh
source conda_env.sh

# install deps
conda install nose pytables hdf5 scipy cython cmake
export CERT_FILE=$(ls $CONDIR/lib/python*/site-packages/requests/cacart.pem)
conda install -c https://conda.binstar.org/cyclus lapack

# Install PyNE
cd pyne
python setup.py install --prefix="${CONDIR}" --hdf5="${CONDIR}" 
cd scripts
env
nuc_data_make
cd ../..

