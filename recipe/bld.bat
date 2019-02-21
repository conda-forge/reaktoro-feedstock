mkdir build
cd build

REM This is a fix for a CMake bug where it crashes because of the "/GL" flag
REM See: https://gitlab.kitware.com/cmake/cmake/issues/16282
set CXXFLAGS=%CXXFLAGS:-GL=%
set CFLAGS=%CFLAGS:-GL=%

cmake -G Ninja ^
      -DREAKTORO_BUILD_ALL=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DREAKTORO_THIRDPARTY_EXTRA_INSTALL_ARGS="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON" ^
      -DCMAKE_INCLUDE_PATH="%LIBRARY_INC%" ^
      -DBOOST_INCLUDE_DIR="%LIBRARY_INC%" ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
      ..
ninja install
