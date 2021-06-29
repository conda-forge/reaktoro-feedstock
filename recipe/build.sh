#!/bin/bash

# Avoid errors on the server such as:
#  - Error: virtual memory exhausted: Cannot allocate memory
#  - Error: Exit code 137
# due to many parallel jobs consuming all available memory
JOBS=$((CPU_COUNT - 1))

echo "Using $JOBS parallel jobs out of $CPU_COUNT available to build Reaktoro and its dependencies."

# Configure the build of the dependencies in the deps directory
cmake -S deps -B deps/build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=install \
    -DPYTHON_EXECUTABLE=$PYTHON

# Build the dependencies in the deps directory
cmake --build deps/build --parallel $JOBS

# Configure the build of Reaktoro
cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DPYTHON_EXECUTABLE=$PYTHON \
    -DREAKTORO_BUILD_PYTHON=ON

# Build and install Reaktoro and the dependencies above in $PREFIX
cmake --build build --target install --parallel $JOBS
