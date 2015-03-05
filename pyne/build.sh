#!/bin/bash
set -e

unset LDFLAGS
export PATH="${PREFIX}/bin:${PATH}"

${PYTHON} setup.py install
nuc_data_make

