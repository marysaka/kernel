#!/bin/bash

set -e

KERNEL_TREE_URL="https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux.git"
KERNEL_SRC_PATH=$PWD/linux
PINNED_BRANCH="rk3588"
PINNED_COMMIT="f66797f47c2edae99153674f332b2eb2749038c6"
ARCHIVE_NAME="linux-6.8-rc7"

if [ ! -d "$KERNEL_SRC_PATH" ]; then
    git clone $KERNEL_TREE_URL $KERNEL_SRC_PATH --branch $PINNED_BRANCH
fi

TARGET_OUTPUT_PATH=$PWD

pushd $KERNEL_SRC_PATH
git remote set-url origin $KERNEL_TREE_URL
git fetch --all

# Setup xz alias for git archive
git config tar.tar.xz.command "xz -c"
git archive --format=tar.xz -o $TARGET_OUTPUT_PATH/$ARCHIVE_NAME.tar.xz --prefix=$ARCHIVE_NAME/ $PINNED_COMMIT
popd

