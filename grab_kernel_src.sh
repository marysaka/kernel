#!/bin/bash

set -e

KERNEL_TREE_URL="https://gitlab.freedesktop.org/panfrost/linux.git"
KERNEL_SRC_PATH=$PWD/linux
PINNED_BRANCH="panthor-v4+rk3588"
PINNED_COMMIT="d47e1c6db9dedd541f86fda0cadd1cb8f10988a5"
ARCHIVE_NAME="linux-6.7-rc3"

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

