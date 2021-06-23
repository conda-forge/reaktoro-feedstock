REM This is a fix for a CMake bug where it crashes because of the "/GL" flag
REM See: https://gitlab.kitware.com/cmake/cmake/issues/16282
if defined CXXFLAGS set CXXFLAGS=%CXXFLAGS:-GL=%
if defined CFLAGS set %CFLAGS:-GL=%
@echo CXXFLAGS: %CXXFLAGS%
@echo CFLAGS: %CFLAGS%

REM This is a fix for a problem in Azure+CMake where CMake is finding a
REM different compiler (GCC, etc.) instead of MSVC
REM See: https://github.com/conda-forge/conda-forge.github.io/issues/714
@echo.
@echo CC: "%CC%" -^> "cl.exe"
set CC=cl.exe
@echo CXX: "%CXX%" -^> "cl.exe"
set CXX=cl.exe

@REM cmake -G Ninja ^
@REM       -DREAKTORO_BUILD_PYTHON=ON ^
@REM       -DREAKTORO_DEPS_EXTRA_BUILD_ARGS="-DCMAKE_VERBOSE_MAKEFILE=ON" ^
@REM       -DCMAKE_BUILD_TYPE=Release ^
@REM       -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
@REM       -DCMAKE_INCLUDE_PATH:PATH="%LIBRARY_INC%" ^
@REM       -DCMAKE_VERBOSE_MAKEFILE=ON ^
@REM       -DPYTHON_EXECUTABLE=%PYTHON% ^
@REM       ..
@REM ninja install

@REM Configure the build of the dependencies in the deps directory
cmake -G Ninja -S deps -B deps/build ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=install ^
    -DPYTHON_EXECUTABLE=%PYTHON%

@REM Build the dependencies in the deps directory
cmake --build deps/build --parallel

@REM Configure the build of Reaktoro
cmake -G Ninja -S . -B build ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DCMAKE_VERBOSE_MAKEFILE=ON ^
    -DPYTHON_EXECUTABLE=%PYTHON% ^
    -DREAKTORO_BUILD_PYTHON=ON

@REM Build and install Reaktoro and the dependencies above in %PREFIX%
cmake --build build --target install --parallel
