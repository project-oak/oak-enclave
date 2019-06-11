#!/bin/bash -e
[ -f /.dev-env ] || { echo "This script is supposed to run within dev-env.sh shell!"; exit 1; }
THIS_SCRIPT=`realpath $0`
THIS_SCRIPT_DIR=`dirname $THIS_SCRIPT`
REPO_DIR=`dirname $THIS_SCRIPT_DIR`
CHERI_REPOS_DIR=$REPO_DIR/cheri-repos

echo ===== Cloning CHERI git repos ======
$THIS_SCRIPT_DIR/checkout-cheri-repos.sh

echo ===== Building CHERI SDK =====
cd $CHERI_REPOS_DIR/cheribuild
./cheribuild.py bmake freestanding-sdk
./cheribuild.py cherios -d

# Creating file with git revision information to identify the build origin
for repo in `ls -d $CHERI_REPOS_DIR/*/.git`; do (
   cd $repo/..
   echo  "`basename $(realpath .)`: `git branch | awk '{print $2}'` `git rev-parse HEAD` "
); done | sort > $REPO_DIR/sdk/git-revisions.txt

