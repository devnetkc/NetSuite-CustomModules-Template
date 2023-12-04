#!/bin/bash

# This script is used by the "generate-manifests" script in the package.json file of 'netsuite-custommodules-template'.
# It flattens the directory structure of NetSuite object files located in ./src/Objects/ and copies them to the build directory.
# The script checks for changes in object files since a specified compare branch (usually 'origin/prod' or 'origin/main').

# Usage: ./flattenObjectPaths.sh [BUILD_DIRECTORY] [COMPARE_BRANCH]

# Parameters:
# - BUILD_DIRECTORY: The destination directory where flattened object files will be copied.
# - COMPARE_BRANCH: The branch to compare against to identify changed object files.

# The script iterates through all object files and compares their change history with the compare branch.
# Only object files with changes will be copied to the build directory for deployment.
# If a duplicate object name is detected, the script exits with an error to alert the user to investigate.

# Example usage in package.json:
# "generate-manifests": "npm run compile-sass && bash .ci/scripts/createDeployment.sh $npm_config_headbranch $npm_config_sourcebranch $npm_config_releaserun $npm_config_flatobjects $npm_config_validaterun",
# "flattenObjectPaths": "bash .ci/scripts/flattenObjectPaths.sh ./build/Objects origin/main origin/prod"

# This script is part of the automated deployment process for NetSuite SuiteCloud projects.

git fetch --all --prune

find ./src/Objects/ -type f \( -iname \*.xml \) | while read relativePath; do
    filePathRegex="\(.*\)/\(.*\)"
    fileName=$(echo "$relativePath" | sed "s:$filePathRegex:\2:g")
    squashedPathName="$1$fileName"

    ## This is where we test if there's a change to this object file.
    ## Only objects with changes will be copied to the build directory for deployment.

    ## Read git log for files impacted since origin headbranch (reverts are also in the log).
    while read line; do
        changeLogFileName=$(echo "$line" | sed "s:$filePathRegex:\2:g")

        ### We only want to copy object files in deployment which have been changed.
        if [[ "$changeLogFileName" =~ $fileName ]]; then
            ### Name matches change log, logic to copy file to build dir passes so far.
            ## Test for duplicate objects and throw an exit error if a duplicate is located.
            if test -f "$squashedPathName"; then
                echo -e "\033[0;31mDUPLICATE_OBJECT_NAME_DETECTED: {squashedPathName: '$squashedPathName', relativePath:'$relativePath'}\033[0m"
                exit 1
            else
                echo "Copying $fileName"
                cp "$relativePath" "$1"
            fi
            break
        fi

        ### Clear line variable
        line=""

    done < <(git log --oneline --stat "origin/$2..$3" --name-only "./src/Objects")
done
