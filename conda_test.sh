#!/bin/bash
set -x
set -e
source conda_env.sh
ls $BLD

tar_dir="pyne-unichr"

# Setup workdir
if [ -d "${BLD}/work/${tar_dir}" ]; then
  export WORKDIR="${BLD}/work/${tar_dir}"
else  
  export WORKDIR="${BLD}/work"
fi

nosetests -w "${WORKDIR}/tests"
