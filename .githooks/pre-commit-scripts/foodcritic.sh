#!/bin/sh
#
# Precommit hook script that runs foodcritic against cookbooks

if git rev-parse --verify HEAD >/dev/null 2>&1
then
	difftarget=HEAD
else
	# Initial commit: diff against an empty tree object
	difftarget=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Redirect output to stderr.
exec 1>&2

fc=$( which foodcritic 2>&1 )
ws=$( pwd )

if [ "${fc}" != "" ]; then

  # Loop through the files that changed and generate a cookbook list
  ruby_files_that_changed=$(git diff --cached --name-status $difftarget | grep cookbooks | awk '$1 != "D" { print $2 }' )
  for onefile in ${ruby_files_that_changed}; do
    # strip off individual recipes
    cookbook=$(echo $onefile | sed -E 's#(/snc_[^/]+)/.*#\1/#')

    if [ "${cookbook}" != "" ]; then
      # if its not already in the list, then add it to the list
      grep_cb=$(echo ${cookbook_list} | grep "${cookbook}")
      if [ "${grep_cb}" = "" ]; then
        cookbook_list="${cookbook_list} ${cookbook}"
      fi
    fi
  done

  # Loop through the cookbook list and run food critic on each cookbook
  for cookbook_dir in ${cookbook_list}; do
    cookbook_name=$(basename ${cookbook_dir})
    echo "Running foodcritic on ${cookbook_name}"
    echo "${fc} ${ws}/${cookbook_dir}"
    ${fc} ${ws}/${cookbook_dir}
    fcstatus=$?
    if [ "$fcstatus" != "0" ]; then
      exit ${fcstatus}
    fi
  done
else
  echo "For best results, install foodcritic/chefdk locally"
fi
