unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    chmod +x Miniconda-3.0.5-Linux-x86_64.sh
    ./Miniconda-3.0.5-Linux-x86_64.sh -b -p `pwd`/anaconda
elif [[ "$unamestr" == 'Darwin' ]]; then
    chmod +x Miniconda-3.0.5-MacOSX-x86_64.sh
    ./Miniconda-3.0.5-MacOSX-x86_64.sh -b -p `pwd`/anaconda
elif [[ "$unamestr" == "CYGWIN_NT-6.1" ]]; then
    Miniconda-3.0.5-Windows-x86.exe -b -p `pwd`/anaconda
else
    echo $unamestr
fi

export LD_LIBRARY_PATH=`pwd`/anaconda/lib:$LD_LIBRARY_PATH
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/anaconda/lib:$DYLD_FALLBACK_LIBRARY_PATH
export DYLD_LIBRARY_PATH=`pwd`/anaconda/lib:$DYLD_LIBRARY_PATH
export C_INCLUDE_PATH=`pwd`/anaconda/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=`pwd`/anaconda/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=`pwd`/anaconda/lib:$LIBRARY_PATH
export HDF5_ROOT=`pwd`/anaconda

cdir=`pwd`/anaconda
export PATH=`pwd`/anaconda/bin:`pwd`/anaconda/usr/local/bin:$PATH
conda install conda-build jinja2 nose setuptools pytables hdf5 scipy cython cmake
if [[ "$unamestr" == 'Linux' ]]; then
    conda install patchelf
fi

cd moab-4.6.3
./configure --prefix=`pwd`/../anaconda --enable-shared --with-hdf5=`pwd`/../anaconda
make
make install
cd ..

cd PyTAPS-1.4
python setup.py build
cd ..

cd PyTAPS-1.4
python setup.py install --skip-build --prefix=`pwd`/../anaconda
cd ..

cd pyne
python setup.py install --prefix=`pwd`/../anaconda --hdf5=`pwd`/../anaconda -- -DMOAB_INCLUDE_DIR=`pwd`/../anaconda/include -DMOAB_LIBRARY=`pwd`/../anaconda/lib



cd scripts
env
nuc_data_make

cd ../..

exit $?
