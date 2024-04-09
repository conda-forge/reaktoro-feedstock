#!/bin/bash

mkdir build
cd build

# Configure the build of Reaktoro
cmake -GNinja .. ${CMAKE_ARGS}  \
    -DCMAKE_BUILD_TYPE=Release  \
    -DPython_EXECUTABLE=$PYTHON \
    -DCMAKE_CXX_FLAGS="$(if [ $(uname) == 'Linux' ]; then echo '-fuse-ld=lld'; else echo ''; fi)"

# Build and test Reaktoro (except when cross-compiling, e.g., osx-arm64 builds)
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  ninja tests
fi

# Install Reaktoro in $PREFIX
ninja install
