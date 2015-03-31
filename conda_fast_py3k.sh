#!/bin/bash
set -x
set -e

# Install conda
export MINICONDA_PYVER="3"
source conda_fast_build.sh
