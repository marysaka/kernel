#!/bin/sh

set -e

arch=$(uname -m)

RPMBUILD_ARGS="--with release --with headers --without debug --without arm64_16k --without arm64_64k --without perf --without libperf"

if [ "$arch" != 'aarch64' ];
then
    RPMBUILD_ARGS="$RPMBUILD_ARGS --with cross"
fi

fedpkg --release f39 local --arch aarch64 -- \
            --define "buildid .panthor" \
            $RPMBUILD_ARGS
