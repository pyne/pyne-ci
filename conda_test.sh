#!/bin/bash
set -x
set -e
source conda_env.sh
ls $BLD

pyne_tar_dir="pyne-unichr"

# Setup workdir
if [ -d "${BLD}/work/${cycamore_tar_dir}" ]; then
  export WORKDIR="${BLD}/work/${cycamore_tar_dir}"
else  
  export WORKDIR="${BLD}/work"
fi

nosetests -w "${WORKDIR}/tests"
