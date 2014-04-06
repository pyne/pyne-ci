PATH=`pwd`/anaconda/bin:$PATH

`pwd`/anaconda/bin/nosetests -w ./pyne/tests

exit $?
