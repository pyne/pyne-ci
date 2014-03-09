set -x
set -e

PYINSTALL=`pwd`/install/lib/python2.7/site-packages

mkdir -p $PYINSTALL

export PATH=`pwd`/install/bin:`pwd`/install/usr/local/bin:$PATH
echo $PATH
export PYTHONPATH=`pwd`/install/lib/python2.7/site-packages:`pwd`/install/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/install/lib/python2.7/site-packages/pyne/lib:`pwd`/install/lib:$DYLD_FALLBACK_LIBRARY_PATH
export C_INCLUDE_PATH=`pwd`/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=`pwd`/install/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=`pwd`/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=`pwd`/install/lib:$LD_LIBRARY_PATH

# install libs
cd hdf5-1.8.4
./configure --prefix=`pwd`/../install --enable-shared 
make
make install
cd ..

cd moab-4.6.2
./configure --prefix=`pwd`/../install --enable-shared --with-hdf5=`pwd`/../install
make
make install
cd ..

mkdir build

cp -r install build/

# build broken python
cd numpy
python setup.py install --prefix=`pwd`/../install
cd ..

# build not broken python
cd nose
python setup.py build
cd ..
cp -r nose build/

cd nose
python setup.py install --skip-build --prefix=`pwd`/../install
cd ..

cd numexpr
python setup.py build
cd ..
cp -r numexpr build/

cd numexpr
python setup.py install --skip-build --prefix=`pwd`/../install
cd ..

cd cython
python setup.py build
cd ..
cp -r cython build/

cd cython
python setup.py install --skip-build --prefix=`pwd`/../install
cd ..

cd PyTAPS-1.4
python setup.py build
cd ..
cp -r PyTAPS-1.4 build/

cd PyTAPS-1.4
python setup.py install --skip-build --prefix=`pwd`/../install
cd ..

cd scipy
python setup.py build
cd ..
cp -r scipy build/

cd scipy
python setup.py install --skip-build --prefix=`pwd`/../install
cd ..

tar -pczf results.tar.gz build

# build dependent python
cd PyTables
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install
cd ..
 
cd pyne
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install -- -DMOAB_INCLUDE_DIR=`pwd`/../install/include -DMOAB_LIBRARY=`pwd`/../install/lib

cd scripts
env
nuc_data_make

cd ../..
exit $?