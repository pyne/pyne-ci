unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    chmod +x Miniconda-3.0.5-Linux-x86_64.sh
    ./Miniconda-3.0.5-Linux-x86_64.sh -b -p `pwd`/anaconda
elif [[ "$unamestr" == 'Darwin' ]]; then
    chmod +x Miniconda-3.0.5-MacOSX-x86_64.sh
    ./Miniconda-3.0.5-MacOSX-x86_64.sh -b -p `pwd`/anaconda
fi

cdir=`pwd`/anaconda
export PATH=`pwd`/anaconda/bin:$PATH
conda install conda-build jinja2 nose setuptools pytables hdf5 scipy
if [[ "$unamestr" == 'Linux' ]]; then
    conda install patchelf
fi
cd conda-recipes
pyneout=$(conda build --output pyne)
conda build pyne
conda install $pyneout
cd ../pyne/scripts
./nuc_data_make
cd ../..
#cd ../tests
#$cdir/bin/nosetests
exit $?
