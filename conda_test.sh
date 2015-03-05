#!/bin/bash
set -x
set -e
source conda_env.sh

nosetests -w ./pyne-src/tests
