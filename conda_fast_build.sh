#!/bin/bash
set -x
set -e

# Install conda
./bin/conda-inst.sh
source conda_env.sh

if [[ "$(uname)" != "Linux" ]]; then
  conda install gcc
fi

# get glibc version, minorly apologetic for this.
export LDD_VER="$(ldd --version)"
export GLIBC_MAJOR_VERSION=$(python -c "print('''${LDD_VER}'''.splitlines()[0].split()[-1].split('.')[0])")
export GLIBC_MINOR_VERSION=$(python -c "print('''${LDD_VER}'''.splitlines()[0].split()[-1].split('.')[1])")

# install deps
conda install nose jinja2 pytables hdf5 scipy cython cmake moab

# Install PyTAPS on Python 2 only
if [[ "$MINICONDA_PYVER" == "2" ]]; then
  conda install pytaps
fi

if [ "14" -gt "$GLIBC_MINOR_VERSION" ]; then
  conda install glibc
fi

# build and install pyne conda package
conda_build pyne
vers=$(cat pyne/meta.yaml | grep version)
read -a versArray <<< $vers
conda install --use-local pyne=${versArray[1]}

# return packages
gzip results.tar
echo ""
echo "Results Listing"
echo "---------------"
tar -ztvf results.tar.gz
