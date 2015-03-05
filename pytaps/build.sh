#!/bin/bash

#python setup.py --iMesh-path=$PREFIX --iGeom-path=$PREFIX --iRel-path=$PREFIX \
python setup.py --iMesh-path=$PREFIX --without-iGeom --iRel-path=$PREFIX \
                install
