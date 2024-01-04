#!/bin/bash

set -e

KERNEL_TREE_URL="https://gitlab.freedesktop.org/bbrezillon/linux.git"
KERNEL_SRC_PATH=$PWD/linux
PINNED_COMMIT="6cad25656baac7cf42ee463a57fa42d940594cf0"
ARCHIVE_NAME="linux-6.7-rc3"

if [ ! -d "$KERNEL_SRC_PATH" ]; then
    git clone $KERNEL_TREE_URL $KERNEL_SRC_PATH
fi

TARGET_OUTPUT_PATH=$PWD

pushd $KERNEL_SRC_PATH
git remote set-url origin $KERNEL_TREE_URL
git fetch --all

# Setup xz alias for git archive
git config tar.tar.xz.command "xz -c"
git archive --format=tar.xz -o $TARGET_OUTPUT_PATH/$ARCHIVE_NAME.tar.xz --prefix=$ARCHIVE_NAME/ $PINNED_COMMIT
popd

