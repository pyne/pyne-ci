#!/bin/bash
set -x
set -e

# Install conda
./bin/conda-inst.sh
source conda_env.sh

# install deps
conda install nose jinja2 pytables hdf5 scipy cython cmake moab

# Install PyTAPS on Python 2 only
if [[ "$MINICONDA_PYVER" == "2" ]]; then
    conda install pytaps
fi

echo "cat /etc/issue"
echo "$(cat /etc/issue)"

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
