#!/usr/bin/env bash
# build script for conda package

set -e
set -x

mkdir build && cd build
cmake \
      ${CMAKE_ARGS} \
      -DPKG_CONFIG_EXECUTABLE=$CONDA_PREFIX/bin/pkg-config \
      -DCMAKE_BUILD_TYPE=Release \
      -DADAFLOW_USE_CUDA=OFF \
      -DADAFLOW_USE_TRT=OFF \
      -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make -j${nproc} && \
make install
