mkdir build
cd build

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

cmake -G Ninja ^
      -DREAKTORO_BUILD_ALL:BOOL=ON ^
      -DREAKTORO_PYTHON_INSTALL_PREFIX:PATH="%PREFIX%" ^
      -DREAKTORO_THIRDPARTY_EXTRA_INSTALL_ARGS="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INCLUDE_PATH:PATH="%LIBRARY_INC%" ^
      -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
      -DBOOST_INCLUDE_DIR:PATH="%LIBRARY_INC%" ^
      -DPYTHON_EXECUTABLE=%PYTHON% ^
      ..
ninja install
