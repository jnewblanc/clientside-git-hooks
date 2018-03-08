#!/bin/bash
#
# Precommit hook script which uses xmllint to validate .xml and .xml.erb files
#
# Goal: Block commits to chef cookbook xml templates if xml is invalid

# Ref to diff against to find changed files
against=HEAD
if [ "$(git rev-parse --verify ${against})" = "" ]; then
  # If it doesn't exist, use initial commit to diff against an empty tree object
  against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Redirect output to stderr.
exec 1>&2

xmllint=$( which xmllint 2>&1 )
ws=$( pwd )

if [ "${xmllint}" != "" ]; then

  # Loop through the files that changed to find relevant files
  files_that_changed=$(git diff --cached --name-status $against | grep '.xml' | awk '$1 != "D" { print $2 }' )
  for onefile in ${files_that_changed}; do
    if [ "$(echo $onefile | grep '.xml.erb')" = "" ]; then
      # Handle plain old xml files
      echo "Running xmllint on ${onefile}"
      cat ${ws}/${onefile} | xmllint --noout -
      cmdstatus=$?
    else
      # Handle xml erb chef templates
      #   Use a sed cmd to strip out the embedded ruby in .erb file.  This works
      #   because we use ruby only to interpolate xml values, and throwing out
      #   the values still results in valid xml.  This could break if ruby code
      #   is added to generate xml tags
      echo "Running xmllint on stripped ${onefile}"
      cat ${ws}/${onefile} | sed -e 's#<%[^%].*%>##' | xmllint --noout -
      cmdstatus=$?
    fi
    if [ "$cmdstatus" != "0" ]; then
      exit ${cmdstatus}
    fi
  done
else
  echo "For best results, install xmllint locally"
fi
