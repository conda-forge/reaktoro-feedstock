mkdir build
cd build

@REM Configure the build of Reaktoro
cmake -GNinja ..                              ^
    -DCMAKE_BUILD_TYPE=Release                ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%   ^
    -DCMAKE_INCLUDE_PATH=%LIBRARY_INC%        ^
    -DREAKTORO_BUILD_TESTS=OFF                ^
    -DREAKTORO_PYTHON_INSTALL_PREFIX=%PREFIX% ^
    -DPYTHON_EXECUTABLE=%PYTHON%

@REM Build and install Reaktoro in %LIBRARY_PREFIX%
ninja install
