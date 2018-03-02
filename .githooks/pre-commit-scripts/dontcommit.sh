#!/bin/sh
#
# Precommit hook script to check for FAILTHECOMMIT content in commits
#
# This script was adapted from a number of pre-existing examples on the web
# Most notably:
#   https://gist.github.com/radekstarczynowski/8598bb59772a7b22d593d2866384fe1d

if [ git rev-parse --verify HEAD >/dev/null 2>&1 ]; then
  difftarget=HEAD
else
  # Initial commit: diff against an empty tree object
  difftarget=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Redirect output to stderr.
exec 1>&2

diffstr=`git diff --cached $difftarget | grep -e '^\+.*FAILTHECOMMIT*$'`
if [[ -n "$diffstr" ]] ; then
  echo "You have left FAILTHECOMMIT in your changes, you can't commit until it has been removed."
  exit 1
fi
