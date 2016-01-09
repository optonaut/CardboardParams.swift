#!/usr/bin/env sh

set -ex

compiler_root=src/compiler

PATH=$PATH:$compiler_root

# compile the unit tests into the runtime library's fixture directory
protoc -I$compiler_root $compiler_root/google/protobuf/unittest*.proto --swift_out=src/ProtocolBuffers/ProtocolBuffersTests/pbTests/
protoc -I$compiler_root $compiler_root/tests/**/*.proto --swift_out=src/ProtocolBuffers/ProtocolBuffersTests/pbTests/

# compile the performance proto into the runtime
protoc -I$compiler_root $compiler_root/google/protobuf/performance.proto  --swift_out=src/ProtocolBuffers/ProtocolBuffersTests
