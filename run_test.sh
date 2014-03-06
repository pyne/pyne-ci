set -x
set -e

export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:`pwd`/install/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH
export PATH=$PATH:`pwd`/install/bin

../../install/bin/nosetests -w tests

exit $?
