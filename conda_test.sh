#!/bin/bash
set -x
set -e
source conda_env.sh
ls 
nosetests -w ./pyne-src/tests
