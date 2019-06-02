#!/bin/bash -e
THIS_SCRIPT=`realpath $0`
THIS_SCRIPT_DIR=`dirname $THIS_SCRIPT`
REPO_DIR=`dirname $THIS_SCRIPT_DIR`
CHERI_REPOS_DIR=$REPO_DIR/cheri-repos

clone() {
  REPO_NAME=$1
  DST_DIR=$CHERI_REPOS_DIR/$REPO_NAME
  shift
  if [ ! -d $DST_DIR ]; then
     echo "***** git clone $@ $DST_DIR"
     git clone "$@" $DST_DIR
  else
     echo "***** $DST_DIR already exists, skipping"
  fi
}

mkdir -p $CHERI_REPOS_DIR
clone cheribuild https://github.com/CTSRD-CHERI/cheribuild
clone llvm-project https://github.com/CTSRD-CHERI/llvm-project
clone qemu https://github.com/CTSRD-CHERI/qemu
clone binutils https://github.com/CTSRD-CHERI/binutils
clone gdb https://github.com/CTSRD-CHERI/gdb
clone cherios https://github.com/CTSRD-CHERI/cherios --recurse-submodules

