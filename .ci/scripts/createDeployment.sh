#!/bin/bash
## Reset Manifest
cp ./.ci/templates/manifest.tpl.xml src/manifest.xml

## Store branch name for release
echo "$2" >./.ci/.branch

## Declare variables
### Create xml schema variables
endOfLine="</path>\n"

### Create regex strings to test with
srcRegex='src\/.*'
attributesRegex='.*\.attributes.*'
fileRegex='src\/FileCabinet\/SuiteScripts.*'
objectRegex='src\/Objects\/.*'
objectScriptPathRegex='.*scriptfile.*'

### Output strings for File and Object lines
#### Add more here if using other branches of deploy.xml schema
FILELINE=
OBJECTLINE=
## Read git log for files impacted since origin headbranch -- reverts are also in the log
while read line; do
    ### We only want to update src files in deployment
    if [[ "$line" =~ $srcRegex ]]; then
        ### Test if file exists, if not we can skip it and import as dependency later
        if ! test -f "$line"; then
            continue
        fi

        ### Setup what the new line will look like
        newLine=$(echo "$line" | sed "s/src\//\t<path>~\//")"$endOfLine"

        ### Skip duplicates -- lines which are already prepped to go in to deploy.xml
        if [[ $OBJECTLINE == *"$newLine"* || $FILELINE == *"$newLine"* ]]; then
            continue
        fi

        ### Separate Files & Objects to build deploy.xml
        if [[ "$line" =~ $fileRegex ]]; then
            if [[ "$line" =~ $attributesRegex ]]; then
                continue
            fi
            #### Is a file update
            FILELINE+="\t${newLine}"
        elif [[ "$line" =~ $objectRegex ]]; then
            ### Test line to see if the object needs a file path dependency added
            while read OBJLINE; do
                if [[ "$OBJLINE" =~ $objectScriptPathRegex ]]; then
                    #### Modify line to deploy.xml schema
                    SCRIPTPATH=$(echo "$OBJLINE" | sed "s/<scriptfile>\[/\/src/")
                    SCRIPTPATH=$(echo "${SCRIPTPATH}" | sed "s/\]<\/scriptfile>//")
                    depLine=$(echo "${SCRIPTPATH}" | sed "s/\/src\//\t<path>~\/FileCabinet\//")"$endOfLine"
                    CLEANPATH=$(echo "$SCRIPTPATH" | sed "s/src\///")
                    regexLineStr=".*$CLEANPATH"

                    #### Check if dependency file is already in file paths list
                    if [[ "$FILELINE" =~ $regexLineStr ]]; then
                        continue
                    fi

                    ##### Add to dependency to file list
                    FILELINE+="\t${depLine}"
                fi
            done < <(cat "./${line}")

            #### Is an object file update
            OBJECTLINE+="\t${newLine}"
        fi
    fi
    ### Clear line variable
    line=""
done < <(git log --oneline --stat origin/$1..$2 --name-only)

## Generate deploy.xml file
### Define output string variable
OUTPUTLINES=""

### If file path entries is > 0 add files to deploy.xml
if [[ $FILELINE ]]; then
    OUTPUTLINES="<files>\n${FILELINE}\t</files>"
fi

### If object path entries is > 0 add objects to deploy.xml
if [[ $OBJECTLINE ]]; then
    OUTPUTLINES="${OUTPUTLINES}\n\t<objects>\n${OBJECTLINE}\t</objects>"
fi

### Print output to custom updated deploy.xml
# shellcheck disable=SC2059
printf "<deploy>
    <configuration>
        <path>~/AccountConfiguration/*</path>
    </configuration>
    ${OUTPUTLINES}
    <translationimports>
        <path>~/Translations/*</path>
    </translationimports>
</deploy>" >src/deploy.xml

## Echo output for logging
cat src/deploy.xml
