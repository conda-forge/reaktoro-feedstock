@REM Execute the Python test application using Reaktoro
python test/example.py

@REM Build and execute the C++ test application using Reaktoro
cd test/app
mkdir build
cd build
cmake -GNinja ..                         ^
    -DCMAKE_BUILD_TYPE=Release           ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%
ninja
app.exe
