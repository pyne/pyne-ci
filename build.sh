set -x
set -e

mkdir -p `pwd`/install/lib/python2.7/site-packages

export PATH=`pwd`/install/bin:$PATH
echo $PATH
export PYTHONPATH=`pwd`/install/lib/python2.7/site-packages:$PYTHONPATH:`pwd`/install
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/../install/lib/python2.7/site-packages/pyne/lib:$DYLD_FALLBACK_LIBRARY_PATH

# cd hdf5-1.8.4
# ./configure --prefix=`pwd`/../install --enable-shared 
# make
# make install
# cd ..

# cd moab-4.6.2
# ./configure --prefix=`pwd`/../install --enable-shared --with-hdf5=`pwd`/../install
# make
# make install
# cd ..

cd nose
python setup.py install --prefix=`pwd`/../install
# cd ../numpy
# python setup.py install --prefix=`pwd`/../install
# cd ../cython
# python setup.py install --prefix=`pwd`/../install
# cd ../scipy
# python setup.py install --prefix=`pwd`/../install
# cd ../numexpr
# python setup.py install --prefix=`pwd`/../install
# cd ../PyTables
# python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install

cd ..
tar -zcvf results.tar.gz install

cd pyne
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install

cd scripts
nuc_data_make

cd ../..
exit $?