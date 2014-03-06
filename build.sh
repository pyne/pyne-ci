set -x
set -e

#libtool --finish `pwd`/install/lib

export PATH=$PATH:`pwd`/install/bin
echo $PATH

cd hdf5-1.8.4
./configure --prefix=`pwd`/../install --enable-shared 
make
make install
cd ..

# cd autoconf-2.69
# ./configure --prefix=`pwd`/../install 
# make
# make install
# cd ..

# cd automake-1.14
# ./configure --prefix=`pwd`/../install 
# make
# make install
# cd ..

# cd libtool-2.4
# ./configure --prefix=`pwd`/../install 
# make
# make install
# cd ..

# cd moab
# ../install/bin/autoheader
# ../install/bin/aclocal -I m4
# ../install/bin/libtoolize -f
# ../install/bin/autoconf
# ../install/bin/automake -a
# ./configure --prefix=`pwd`/../install --enable-shared --with-hdf5=`pwd`/../install
# make
# make install
# cd ..

cd moab-4.6.2
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


cd ..
tar -zcvf install.tar.gz install

cd pyne
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:`pwd`/../install/lib/python2.7/site-packages

cd scripts
nuc_data_make

cd ../..
exit $?