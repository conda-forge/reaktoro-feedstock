mkdir build
cd build

@REM Configure the build of Reaktoro
cmake -GNinja ..                              ^
    -DCMAKE_BUILD_TYPE=Release                ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%   ^
    -DCMAKE_INCLUDE_PATH=%LIBRARY_INC%        ^
    -DREAKTORO_PYTHON_INSTALL_PREFIX=%PREFIX% ^
    -DPython_EXECUTABLE=%PYTHON%

@REM Build and test Reaktoro
@REM ninja tests  # Fix issue first that reaktoro4py cannot be found during the pybind11-stubgen

@REM Install Reaktoro in %LIBRARY_PREFIX%
ninja install
