set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH

../../install/bin/nosetests -w tests

exit $?
