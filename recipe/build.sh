#!/usr/bin/env bash
# build script for conda package

set -e
set -x

mkdir build && cd build
if [[ -z "$CUDA_PATH" ]]; then
cmake \
      ${CMAKE_ARGS} \
      -DPKG_CONFIG_EXECUTABLE=$CONDA_PREFIX/bin/pkg-config \
      -DCMAKE_BUILD_TYPE=Release \
      -DADAFLOW_USE_CUDA=OFF \
      -DADAFLOW_USE_TRT=OFF \
      -DADAFLOW_CUDA_VERSION=$CONDA_OVERRIDE_CUDA \
      -DCMAKE_INSTALL_PREFIX=$PREFIX ..
else
cmake \
      ${CMAKE_ARGS} \
      -DPKG_CONFIG_EXECUTABLE=$CONDA_PREFIX/bin/pkg-config \
      -DCMAKE_BUILD_TYPE=Release \
      -DADAFLOW_USE_CUDA=ON \
      -DADAFLOW_USE_TRT=ON \
      -DCMAKE_INSTALL_PREFIX=$PREFIX ..
fi
make -j${nproc} && \
make install
