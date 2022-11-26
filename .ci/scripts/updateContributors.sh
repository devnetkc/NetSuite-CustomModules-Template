#!/bin/bash
echo $(pwd)
SCRIPT_DIR=$(pwd)
# Assign the filename
README_TPL="$SCRIPT_DIR/.ci/templates/README.hbs"
README_TPL_TEMP="$SCRIPT_DIR/.ci/templates/README.temp.hbs"
# Create temporary files
CONTRIBUTORS_FILE="$SCRIPT_DIR/.ci/templates/contributors.temp.md"
cp $README_TPL $README_TPL_TEMP
touch $CONTRIBUTORS_FILE

# Run contributor update to contributor temp file
npx contributor-table --dirname "$SCRIPT_DIR" --readme $CONTRIBUTORS_FILE

# Add our emoji back to header
sed -i "" s/"## Contributors"/"## 👥 Contributors"/ $CONTRIBUTORS_FILE

# Store our files to merge
README_OUTPUT=$(<$README_TPL)
CONTRIBUTOR_OUTPUT=$(<$CONTRIBUTORS_FILE)
# Merge files replacing pointer in TPL file
echo $README_OUTPUT
echo $CONTRIBUTOR_OUTPUT
echo "${README_OUTPUT//"{{Contributors}}"/$CONTRIBUTOR_OUTPUT}" >$README_TPL_TEMP

# Clean up contributor temp file
rm $CONTRIBUTORS_FILE

# Sound of script completed
echo -e "\033[0;32m Contributors Updated \033[0m"
