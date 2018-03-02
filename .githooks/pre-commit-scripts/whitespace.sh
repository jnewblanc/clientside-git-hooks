#!/bin/sh
#
# Hook script to check for git whitespace
#

if git rev-parse --verify HEAD >/dev/null 2>&1
then
	difftarget=HEAD
else
	# Initial commit: diff against an empty tree object
	difftarget=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Redirect output to stderr.
exec 1>&2

# If there are whitespace errors, print the offending file names and fail.
git diff-index --check --cached $difftarget --
exitstatus=$?
if [ "${exitstatus}" != "0" ] ; then
    echo "Remove whitespace and retry"
    exit 1
fi
