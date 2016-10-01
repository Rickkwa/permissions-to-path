#!/bin/bash

if [ $# -gt 1 ]; then
    exit 2
fi

if [ -z $1 ]; then
    curpath=.
else
    curpath=$1
fi

curpath=`readlink -f $curpath`

while [ "$curpath" != "/" ]; do
    ls -ld $curpath
    curpath=`dirname $curpath`
done


# TODO:
# - check that the path exists before listing permissions
#     - what happens if it doesn't exist? Exit gracefully with error msg? Ignore this folder and keep traversing up?
# - test for symbolic links

# Options:
# - reverse output order
# - follow symlinks - ie. given an option, will use the actual path instead of a symlink
