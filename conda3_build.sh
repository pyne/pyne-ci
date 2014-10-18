unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    chmod +x Miniconda3-3.7.0-Linux-x86_64.sh
    ./Miniconda3-3.7.0-Linux-x86_64.sh -b -p `pwd`/anaconda
elif [[ "$unamestr" == 'Darwin' ]]; then
    chmod +x Miniconda3-3.3.0-MacOSX-x86_64.sh
    ./Miniconda3-3.3.0-MacOSX-x86_64.sh -b -p `pwd`/anaconda
fi

export LD_LIBRARY_PATH=`pwd`/anaconda/lib:$LD_LIBRARY_PATH
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/anaconda/lib:$DYLD_FALLBACK_LIBRARY_PATH
export DYLD_LIBRARY_PATH=`pwd`/anaconda/lib:$DYLD_LIBRARY_PATH
export C_INCLUDE_PATH=`pwd`/anaconda/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=`pwd`/anaconda/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=`pwd`/anaconda/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=`pwd`/anaconda/lib:$LD_LIBRARY_PATH
export HDF5_ROOT=`pwd`/anaconda

cdir=`pwd`/anaconda
export PATH=`pwd`/anaconda/bin:`pwd`/anaconda/usr/local/bin:$PATH
conda install conda-build jinja2 nose setuptools pytables hdf5 scipy cython cmake
if [[ "$unamestr" == 'Linux' ]]; then
    conda install patchelf
fi

cd pyne
python setup.py install --prefix=`pwd`/../anaconda --hdf5=`pwd`/../anaconda

cd scripts
env
nuc_data_make

cd ../..

exit $?
