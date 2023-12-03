#!/bin/bash
#   Test with `npm run generate-manifests --headbranch=production --sourcebranch=sandbox`
## Exit if file exists and on release
### Control variable
deployFile=0
FLAT_OBJECTS="NO"
GIT_BRANCHES="origin/$1..$2"
### Test if deploy file exists.  If it doesn't we cannot exit, we need to make one
if test -f "src/deploy.xml"; then
    deployFile=1
fi
### If the file exists and we are on release run, then we can exit and not rebuild off changes.
echo "Deploy: $3"
if [[ $deployFile && $3 == "YES" ]]; then
    echo "File aleady created"
    cat "src/deploy.xml"
    exit 0
fi
## Test if we need to use Object Directory
echo "Use Build Directory: $4"
if [[ $4 == "YES" ]]; then
    FLAT_OBJECTS="YES"
    echo "Use flat Object paths on"
fi
## Test if we are validating repository
echo "Running Validation: $5"
if [[ $5 == "YES" ]]; then
    GIT_BRANCHES="origin/$1..origin/$2"
    echo "Validating Repo"
fi

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
filePathRegex="\(.*\)/\(.*\)"
### Create new script file list before writing to list
#### Ignoring the scripts for now
####    printf "" >scriptFileList.rv-test.txt
### Create new object file list before writing to list
printf "" >objectFileList.pipeline-test.txt

## Read git log for files impacted since origin headbranch -- reverts are also in the log
while read line; do
    ### We don't want to update sass/scss files, only css
    if [[ $line =~ \.(scss|sass|css)$ && $line != *.min.css ]]; then
        #### scss file detected, continuing
        continue
    fi
    ### We only want to update src files in deployment
    if [[ "$line" =~ $srcRegex ]]; then
        ADJUSTED_LINE="$line"
        if [[ "$line" =~ $objectRegex && $FLAT_OBJECTS == "YES" ]]; then
            fileName=$(echo "$line" | sed "s:$filePathRegex:\2:g")
            ADJUSTED_LINE="src/Objects/$fileName"
        fi
        echo "Evaluating: $ADJUSTED_LINE"
        ### Test if file exists, if not we can skip it and import as dependency later
        if ! test -f "$ADJUSTED_LINE"; then
            continue
        fi

        ### Setup what the new line will look like
        newLine=$(echo "$ADJUSTED_LINE" | sed "s/src\//\t<path>~\//")"$endOfLine"

        ### Skip duplicates -- lines which are already prepped to go in to deploy.xml
        if [[ $OBJECTLINE == *"$newLine"* || $FILELINE == *"$newLine"* ]]; then
            continue
        fi

        ### Separate Files & Objects to build deploy.xml
        if [[ "$ADJUSTED_LINE" =~ $fileRegex ]]; then
            if [[ "$ADJUSTED_LINE" =~ $attributesRegex ]]; then
                continue
            fi
            #### Is a file update
            #   echo "$line" >>scriptFileList.rv-test.txt
            FILELINE+="\t${newLine}"
        elif [[ "$ADJUSTED_LINE" =~ $objectRegex ]]; then
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
            done < <(cat "./${ADJUSTED_LINE}")

            #### Is an object file update
            ##### Output object file to validate if changed
            echo "${ADJUSTED_LINE}" >>objectFileList.pipeline-test.txt
            ##### Add object line to list of dependencies for deployment
            OBJECTLINE+="\t${newLine}"
        fi
    fi
    ### Clear line variable
    line=""
done < <(git log --oneline --stat "$GIT_BRANCHES" --name-only)

## Generate deploy.xml file
### Define output string variable
OUTPUTLINES=""

### If file path entries is > 0 add files to deploy.xml
if [[ $FILELINE ]]; then
    echo "##vso[task.setvariable variable=RELEASE_BUILD]true"
    OUTPUTLINES="<files>\n${FILELINE}\t</files>"
fi

### If object path entries is > 0 add objects to deploy.xml
if [[ $OBJECTLINE ]]; then
    echo "##vso[task.setvariable variable=RELEASE_BUILD]true"
    OUTPUTLINES="${OUTPUTLINES}\n\t<objects>\n${OBJECTLINE}\t</objects>"
fi

### Print output to custom updated deploy.xml
echo "Wrinting Output"
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
