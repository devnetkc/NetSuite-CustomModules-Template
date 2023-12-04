#!/bin/bash
# Script Name: findMissingDependents.sh
# Purpose:
# This script is used to validate that NetSuite SuiteScript files in the repository
# have corresponding SuiteCloud objects on the server. It's essential for ensuring
# that all necessary script files are present and accounted for on the server.

# Usage: ./findMissingDependents.sh

# Functionality:
# - The script reads a list of script IDs from a specified file (OBJFILE).
# - For each script ID, it attempts to import the corresponding SuiteCloud object using the SuiteCloud CLI.
# - If the import fails (indicating the SuiteCloud object is missing on the server),
#   the script logs the script ID to an error file (ERRORFILE).
# - This process helps identify discrepancies between the repository and the server,
#   particularly missing SuiteCloud objects that may need attention.

# Example usage in package.json:
# "find-missing-dependents": "bash .ci/scripts/findMissingDependents.sh"

SCRIPTIDREGEX="scriptid=\"(.*)\""
SCRIPTIDSEDREGEX="\(.*\)scriptid=\"\(.*\)\"\(.*\)"
OBJFILE="./deplist.rv-test.txt"
DESTDIR="/Objects/_tmp/"
FULLDESTDIR="./src/$DESTDIR"
ERRORFILE="$FULLDESTDIR/errorList.txt"

mkdir $FULLDESTDIR
echo "" >$ERRORFILE

while read line; do
    SCRIPTID=$line
    echo "Checking: $SCRIPTID"
    {
        npm run import-suitecloud-object --destinationfolder=$DESTDIR --scriptid=$SCRIPTID
    } || {
        echo "$line" >>$ERRORFILE
    }
done < <(cat $OBJFILE)
