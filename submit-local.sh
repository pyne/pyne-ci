#!/bin/bash

if [ -z $1 ]
then
   echo "Error: No run-spec specified"
   exit 1
fi

path=$(pwd)
echo "
method    = scp
scp_file  = ${path}/*
recursive = true
" > ${path}/fetch/pyne-ci-local.scp

cp $1 local-$1
sed -i 's:fetch/pyne-ci.git:fetch/pyne-ci-local.scp:' local-$1
nmi_submit local-$1