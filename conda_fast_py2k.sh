#!/bin/bash
set -x
set -e

# Install conda
export MINICONDA_PYVER="2"
source conda_fast_build.sh
