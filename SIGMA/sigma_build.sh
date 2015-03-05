#!/bin/bash
set -x
set -e
shopt -s expand_aliases

# Install conda
export MINICONDA_PYVER="2"
./bin/conda-inst.sh
source conda_env.sh

# install deps
conda install hdf5 autoconf automake libtool

# build and install SIGMA tools
conda_build cgm
conda_build moab
conda_build lasso
conda_build pytaps

# return packages
gzip results.tar
echo ""
echo "Results Listing"
echo "---------------"
tar -ztvf results.tar.gz