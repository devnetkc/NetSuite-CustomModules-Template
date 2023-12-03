#!/bin/bash
# Script Name: findMissingDependents.sh
# Purpose:
# This script aims to ensure that the local repository is up-to-date with the NetSuite deployment server's state.
# It serves as a safeguard against conflicts that may arise when changes made directly through the NetSuite server's UI
# are not yet merged into the production branch of the repository. This is critical to prevent overwriting changes made
# on the server that are not reflected in the repository.

# Functionality:
# 1. The script reads a list of SuiteCloud object identifiers (script IDs) from a designated file (OBJFILE).
# 2. It then attempts to import each SuiteCloud object corresponding to these script IDs from the NetSuite server.
# 3. If an import attempt fails, the script logs the script ID to an error file (ERRORFILE). This failure indicates
#    a potential discrepancy between the server and the repository, necessitating further review.

# Usage:
# - Run this script as part of the deployment process, ideally before committing changes to the production branch.
# - This ensures synchronization between the local branch and the server, avoiding potential deployment conflicts.

# Requirements:
# - OBJFILE: A file listing the script IDs to be checked. Ensure this file is updated with relevant script IDs.
# - The script creates a temporary directory (FULLDESTDIR) for storing imported objects.
# - Errors and discrepancies are logged in ERRORFILE, located within the FULLDESTDIR path.

# Regular expressions for parsing script IDs
SCRIPTIDREGEX="scriptid=\"(.*)\""
SCRIPTIDSEDREGEX="\(.*\)scriptid=\"\(.*\)\"\(.*\)"

# File containing the list of script IDs to be validated
OBJFILE="./deplist.pipeline-test.txt"
# Uncomment to display the contents of OBJFILE (for debugging purposes)
# cat "$OBJFILE"

# Directory paths for temporary object storage and error logging
DESTDIR="/Objects/_tmp/"
FULLDESTDIR="./src/$DESTDIR"
ERRORFILE="$FULLDESTDIR/errorList.txt"

# Create the destination directory and initialize the error file
mkdir -p $FULLDESTDIR # '-p' ensures the script does not fail if the directory already exists
echo "" >$ERRORFILE   # Initialize the error file

# Main loop to process each script ID in OBJFILE
while read line; do
    SCRIPTID=$line
    echo "Checking: $SCRIPTID"
    # Attempt to import the SuiteCloud object for the given script ID
    # Log the script ID to ERRORFILE if the import command fails
    {
        npm run import-suitecloud-object --destinationfolder=$DESTDIR --scriptid=$SCRIPTID
    } || {
        echo "Failed to import: $line" >>$ERRORFILE
    }
done < <(cat $OBJFILE)
