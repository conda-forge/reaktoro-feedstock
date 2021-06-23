#!/bin/bash
cmake -P deps/install
mkdir build
cd build
cmake -DREAKTORO_BUILD_PYTHON=ON \
      -DREAKTORO_DEPS_EXTRA_BUILD_ARGS="-DCMAKE_VERBOSE_MAKEFILE=ON" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="$PREFIX" \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DPYTHON_EXECUTABLE=$PYTHON \
      ..
make VERBOSE=1 -j${CPU_COUNT}
make install
