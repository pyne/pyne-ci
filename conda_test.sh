#!/bin/bash
set -x
set -e
source conda_env.sh

tar_dir="pyne-ci"

# Setup workdir
if [ -d "${BLD}/work/${tar_dir}" ]; then
  export WORKDIR="${BLD}/work/${tar_dir}"
else  
  export WORKDIR="${BLD}/work"
fi

cd "${WORKDIR}/tests"
nosetests -vs
cd
