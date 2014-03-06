set -x
set -e

libtool --finish `pwd`/install/lib

cd hdf5-1.8.4
./configure --prefix=`pwd`/../install --enable-shared 
make
make install
cd ..

cd moab
autoreconf -fi
./configure --prefix=`pwd`/../install --enable-shared --with-hdf5=`pwd`/../install
make
make install
cd ..

mkdir -p `pwd`/install/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
cd nose
python setup.py install --prefix=`pwd`/../install
cd ../numpy
python setup.py install --prefix=`pwd`/../install
cd ../cython
python setup.py install --prefix=`pwd`/../install
cd ../scipy
python setup.py install --prefix=`pwd`/../install
cd ../numexpr
python setup.py install --prefix=`pwd`/../install
cd ../PyTables
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install

cd ../pyne
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install

exit $?