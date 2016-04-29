#!/bin/bash

# Stop on errors
set -ex 

# Get the directory containing this script
# see http://stackoverflow.com/a/246128/1360263
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Into the pypi directory
cd ${DIR}/../pypi

# # Build the .tar.gz with the sources
# source /py27/bin/activate
# python prepare_pypi.py --dist-dir=`pwd`/../dist
# deactivate

cd ${DIR}/..
rm -rf cmake_build
for PYBIN in /py*; do
    source ${PYBIN}/bin/activate
    c++ --version
    python setup.py bdist_wheel cmake=default,64 --install-dir
    deactivate
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    source /py27/bin/activate
    auditwheel repair $whl -w /io/wheelhouse/
    deactivate
done