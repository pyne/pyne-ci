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

ls -R install

export PATH=`pwd`/install/bin:$PATH
echo $PATH
export PYTHONPATH=`pwd`/install/lib/python2.7/site-packages:$PYTHONPATH
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/../install/lib/python2.7/site-packages/pyne/lib:$DYLD_FALLBACK_LIBRARY_PATH

cd pyne
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install

cd scripts
env
nuc_data_make

cd ../..
exit $?