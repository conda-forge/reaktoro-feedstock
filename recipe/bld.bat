@REM Configure the build of the dependencies in the deps directory
cmake -S deps -B deps/build ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=install ^
    -DPYTHON_EXECUTABLE=%PYTHON%

@REM Build the dependencies in the deps directory
@REM Note: No need for --parallel below, since cmake takes care of the /MP flag for MSVC
cmake --build deps/build

@REM Configure the build of Reaktoro
cmake -S . -B build ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
    -DCMAKE_VERBOSE_MAKEFILE=ON ^
    -DPYTHON_EXECUTABLE=%PYTHON% ^
    -DREAKTORO_BUILD_PYTHON=ON

@REM Build and install Reaktoro and the dependencies above in %LIBRARY_PREFIX%
@REM Note: No need for --parallel below, since cmake takes care of the /MP flag for MSVC
cmake --build build --target install
