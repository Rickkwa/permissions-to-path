#!/bin/bash

print_usage() {
    cat << EOF
Usage: $0 [OPTIONS] [PATH]
List the permissions for all the directories on the way to the given path.

OPTIONS:
    -c, --color		Display the directory/file with colors through 'ls --color'.
    -r, --reverse	Display the permissions in reverse order (shows the permission to the given path last).
    --help			Shows usage information for this tool.
EOF
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
        *) break ;;
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

# Check that the path exists
if [ ! -f $curpath ] && [ ! -d $curpath ]; then
    echo "Error: the path does not exist"
    exit 1
fi

while [ "$curpath" != "/" ]; do
    ls -ld $lsColor $curpath
    curpath=`dirname $curpath`
done
ls -ld $lsColor $curpath # List permissions to /


# TODO:
# - test for symbolic links

# Options:
# - reverse output order
# - follow symlinks - ie. given an option, will use the actual path instead of a symlink

