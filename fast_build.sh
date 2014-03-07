set -x
set -e

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi
if [[ $platform == 'linux' ]]; then
    echo "In linux, untaring ubuntu.tar.gz"
    tar -xzf ubuntu.tar.gz
elif [[ $platform == 'darwin' ]]; then
    echo "In darwin, untaring mac.tar.gz"
    tar -xzf mac.tar.gz
fi

export PATH=`pwd`/install/bin:`pwd`/install/usr/local/bin:$PATH
echo $PATH
export PYTHONPATH=`pwd`/install/lib/python2.7/site-packages:`pwd`/install/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/install/lib/python2.7/site-packages/pyne/lib:$DYLD_FALLBACK_LIBRARY_PATH
export C_INCLUDE_PATH=`pwd`/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=`pwd`/install/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=`pwd`/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=`pwd`/install/lib:$LD_LIBRARY_PATH

python get-pip.py --root `pwd`/install
#ls -R `pwd`/install

pip install --root `pwd`/install nose
pip install --root `pwd`/install numpy
pip install --root `pwd`/install cython
pip install --root `pwd`/install scipy
pip install --root `pwd`/install numexpr
# cd nose
# python setup.py install --prefix=`pwd`/../install
# cd ../numpy
# python setup.py install --prefix=`pwd`/../install
# cd ../cython
# python setup.py install --prefix=`pwd`/../install
# cd ../scipy
# python setup.py install --prefix=`pwd`/../install
# cd ../numexpr
# python setup.py install --prefix=`pwd`/../install
cd ../PyTables
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install

cd pyne
echo "pwd and env"
echo $PWD
env
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install
# -- -DCMAKE_PREFIX_PATH=`pwd`/../install

cd scripts
env
nuc_data_make

cd ../..
exit $?