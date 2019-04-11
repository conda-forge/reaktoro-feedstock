mkdir build
cd build

REM This is a fix for a CMake bug where it crashes because of the "/GL" flag
REM See: https://gitlab.kitware.com/cmake/cmake/issues/16282
set CXXFLAGS=%CXXFLAGS:-GL=%
set CFLAGS=%CFLAGS:-GL=%

cmake -G Ninja ^
      -DREAKTORO_BUILD_ALL:BOOL=ON ^
      -DREAKTORO_PYTHON_INSTALL_PREFIX:PATH="%PREFIX%" ^
      -DREAKTORO_THIRDPARTY_EXTRA_INSTALL_ARGS="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INCLUDE_PATH:PATH="%LIBRARY_INC%" ^
      -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
      -DBOOST_INCLUDE_DIR:PATH="%LIBRARY_INC%" ^
      ..
ninja install
