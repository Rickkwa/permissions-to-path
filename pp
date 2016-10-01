#!/bin/bash

print_usage() {
    echo "Usage: $0"
}

# Parse flag arguments
ARGS=$(getopt -o 'rc' --long color,reverse,help -n "$0" -- "$@")
if [ $? -ne 0 ]; then
	echo "Try running '$0 --help' for more information."
    exit 2
fi
eval set -- "$ARGS"
while true; do
    case "$1" in 
        --help)
            print_usage ; exit 2 ;;
        -c|--color)
            lsColor="--color"
            shift ;;
        -r|--reverse)
            shift ;;
        --) shift; break ;;
        *) echo "ASD123"; break ;;
    esac
done

# Check that the number of real arguments is valid
if [ $# -gt 1 ]; then
	echo "Too many args: $#"
    exit 2
fi

# Set the path to the given path, or default to the current directory if none was given
if [ -z $1 ]; then
    curpath=.
else
    curpath=$1
fi

curpath=`readlink -f $curpath`

while [ "$curpath" != "/" ]; do
    ls -ld $lsColor $curpath
    curpath=`dirname $curpath`
done


# TODO:
# - check that the path exists before listing permissions
#     - what happens if it doesn't exist? Exit gracefully with error msg? Ignore this folder and keep traversing up?
#     - if path exists and is a file, list it anyways ls -l, else it is a directory then use ls -ld
# - test for symbolic links

# Options:
# - reverse output order
# - follow symlinks - ie. given an option, will use the actual path instead of a symlink
# - --color to use ls --color

# Usage message
