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
    tar -xzf ubuntu.fast.tar.gz
elif [[ $platform == 'darwin' ]]; then
    tar -xzf mac.fast.tar.gz
fi

export PATH=$PATH:`pwd`/install/bin
echo $PATH

cd pyne
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:`pwd`/../install/lib/python2.7/site-packages

cd scripts
nuc_data_make

cd ../..
exit $?