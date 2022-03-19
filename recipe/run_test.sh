#!/bin/sh

# Execute the Python test application using Reaktoro
python test/example.py

# Build and execute the C++ test application using Reaktoro
cd test/app
mkdir build
cd build
cmake -GNinja .. -DCMAKE_PREFIX_PATH=$PREFIX
ninja
./app
