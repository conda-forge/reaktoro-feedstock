#!/bin/bash

# Configure the build of the dependencies in the deps directory
cmake -S deps -B deps/build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=install \
    -DPYTHON_EXECUTABLE=$PYTHON

# Build the dependencies in the deps directory
cmake --build deps/build --parallel

# Configure the build of Reaktoro
cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DPYTHON_EXECUTABLE=$PYTHON \
    -DREAKTORO_BUILD_PYTHON=ON

# Build and install Reaktoro and the dependencies above in $PREFIX
cmake --build build --target install --parallel
