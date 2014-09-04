PATH=`pwd`/anaconda/bin:$PATH

export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/anaconda/lib:`pwd`/anaconda/lib/python2.7/site-packages/itaps:$DYLD_FALLBACK_LIBRARY_PATH
export DYLD_LIBRARY_PATH=`pwd`/anaconda/lib:`pwd`/anaconda/lib/python2.7/site-packages/itaps:$DYLD_LIBRARY_PATH

`pwd`/anaconda/bin/nosetests -w ./pyne/tests

exit $?
