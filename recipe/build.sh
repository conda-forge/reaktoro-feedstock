#!/bin/bash

mkdir build
cd build

# Configure the build of Reaktoro
cmake -GNinja .. ${CMAKE_ARGS}  \
    -DCMAKE_BUILD_TYPE=Release  \
    -DREAKTORO_BUILD_TESTS=OFF  \
    -DPYTHON_EXECUTABLE=$PYTHON

# Build and install Reaktoro in $PREFIX
ninja install
