@REM Build and execute C++ test application using Reaktoro
cd test/app
mkdir build
cd build
cmake -GNinja ..                         ^
    -DCMAKE_BUILD_TYPE=Release           ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%
ninja
app.exe
