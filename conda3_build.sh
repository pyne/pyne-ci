#!/bin/bash
set -x
set -e

# Install conda
export MINICONDA_PYVER="3"
./bin/conda-inst.sh
source conda_env.sh

# install deps
conda install nose pytables hdf5 scipy cython cmake
conda install -c http://conda.binstar.org/cyclus lapack

# Install PyNE
cd pyne
python setup.py install --prefix="${CONDIR}" --hdf5="${CONDIR}" 
cd scripts
env
nuc_data_make
cd ../..

