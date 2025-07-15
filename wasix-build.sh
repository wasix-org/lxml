#! /bin/bash

set -exuo pipefail

rm -rf build dist *.egg-info

source .cross-venv/bin/activate

DEPS_DIR=$(realpath ../python-wasix-binaries)

export WASIXCC_SYSROOT=/home/arshia/repos/wasmer/wasix-libc/sysroot32-ehpic/
export WASIXCC_WASM_EXCEPTIONS=yes
export WASIXCC_PIC=yes
export WASIXCC_COMPILER_FLAGS="-I$DEPS_DIR/include/libxml2:-I$DEPS_DIR/include/libxslt"
export WASIXCC_LINKER_FLAGS="-L$DEPS_DIR/lib:-lxml2:-lxslt:-lexslt:-lz:-llzma:-licuuc:-licui18n:-licuio:-licutu:-licudata"
export STATICBUILD=True
export LXML_STATIC_LIBRARY_DIRS=$DEPS_DIR/lib
export LIBRARY=$DEPS_DIR/lib
python -m build --wheel .