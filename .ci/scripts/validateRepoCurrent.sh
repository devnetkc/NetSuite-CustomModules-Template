#!/bin/bash

# Script Name: validateRepoCurrent.sh
# Purpose:
# This script ensures the local repository's NetSuite object files are synchronized with the server state.
# It's designed to prevent conflicts that may arise when changes made directly in the NetSuite server UI
# have not been incorporated into the repository's main branch. By checking against the server,
# the script helps avoid overwriting server-side changes that haven't been merged into the repository.

# Usage: ./validateRepoCurrent.sh

# Functionality:
# - The script reads a list of object files (objectFileList.pipeline-test.txt).
# - For each object, it checks for a "scriptid" attribute and runs the "update-suitecloud-object" script.
#   This fetches the latest version of each object from the NetSuite server, ensuring synchronization.
# - The script also checks the Git repository's status for pending changes.
# - If there are uncommitted changes, the deployment process is halted to prevent overwriting.
# - If no changes are pending, it confirms the repository is ready for deployment.

# Example usage in package.json:
# "validate-repo-current": "bash .ci/scripts/validateRepoCurrent.sh"

SCRIPTIDREGEX="scriptid=\"(.*)\""
SCRIPTIDSEDREGEX="\(.*\)scriptid=\"\(.*\)\"\(.*\)"
OBJFILE="./objectFileList.pipeline-test.txt"
cat "$OBJFILE"
while read OBJLINE; do
    while read line; do
        SCRIPTID=
        if [[ "$line" =~ $SCRIPTIDREGEX ]]; then
            # ScriptID found on the first line
            SCRIPTID=$(echo "$line" | sed "s:$SCRIPTIDSEDREGEX:\2:g")
            echo "Checking: $SCRIPTID"
            npm run update-suitecloud-object --scriptid=$SCRIPTID
            break
        fi

    done < <(cat "$OBJLINE")

done < <(cat "$OBJFILE")

# Checking for uncommitted changes in the Git repository
git status --porcelain
if [[ $(git status --porcelain) ]]; then
    # Changes detected
    echo "Repository Changes Pending: ABORT!"
    # Flag to stop the deployment process in case of pending changes
    echo "##vso[task.setvariable variable=sfdxExitCode;]1" # Stops the build event for error checking
else
    # No changes detected
    echo "Repository Current: Ready for Deployment!"
fi
