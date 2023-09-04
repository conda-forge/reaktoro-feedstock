#!/bin/bash

mkdir build
cd build

# Configure the build of Reaktoro
cmake -GNinja .. ${CMAKE_ARGS}  \
    -DCMAKE_BUILD_TYPE=Release  \
    -DPYTHON_EXECUTABLE=$PYTHON \
    -DCMAKE_CXX_FLAGS="$(if [ $(uname) == 'Linux' ]; then echo '-fuse-ld=lld'; else echo ''; fi)"

# Build and test Reaktoro
ninja tests

# Install Reaktoro in $PREFIX
ninja install
