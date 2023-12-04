#!/bin/bash
# Script Usage: Test with `npm run generate-manifests --headbranch=production --sourcebranch=sandbox`

## Initial Checks and Setup
### Checks if deploy.xml exists and exits if on a release run
# deployFile: Flag to check existence of deploy.xml (0 = not exist, 1 = exist)
# FLAT_OBJECTS: Flag to determine if flat object paths are used ("NO" by default)
# GIT_BRANCHES: Specifies the range of branches to consider for deployment
deployFile=0
FLAT_OBJECTS="NO"
GIT_BRANCHES="origin/$1..$2"

### Exit Logic for Existing deploy.xml on Release Run
# Exits if deploy.xml exists and script is run for a release
if test -f "src/deploy.xml"; then
    deployFile=1
fi
echo "Deploy: $3"
if [[ $deployFile && $3 == "YES" ]]; then
    echo "File already created"
    cat "src/deploy.xml"
    exit 0
fi

### Configuration for Object Directory and Repository Validation
# Checks and sets flags based on script arguments for object directory usage and repo validation
echo "Use Build Directory: $4"
if [[ $4 == "YES" ]]; then
    FLAT_OBJECTS="YES"
    echo "Use flat Object paths on"
fi
echo "Running Validation: $5"
if [[ $5 == "YES" ]]; then
    GIT_BRANCHES="origin/$1..origin/$2"
    echo "Validating Repo"
fi

## Manifest and Branch Setup
### Resetting and Storing Manifest and Branch Information
# Copies template manifest and stores the branch name for release
cp ./.ci/templates/manifest.tpl.xml src/manifest.xml
echo "$2" >./.ci/.branch

## Variable Declaration
### Defining Schema and Regex Patterns for Processing
# Variables for XML schema and various regex patterns for file and object identification
endOfLine="</path>\n"
srcRegex='src\/.*'
attributesRegex='.*\.attributes.*'
fileRegex='src\/FileCabinet\/SuiteScripts.*'
objectRegex='src\/Objects\/.*'
objectScriptPathRegex='.*scriptfile.*'
FILELINE=
OBJECTLINE=
filePathRegex="\(.*\)/\(.*\)"

### Preparation for File and Object List Generation
# Initializes the object file list for pipeline testing
printf "" >objectFileList.pipeline-test.txt

## Git Log Processing
### Reading Git Log to Identify Modified Files
# Processes git log to update src files in the deployment, excluding certain file types
while read line; do
    if [[ $line =~ \.(scss|sass|css)$ && $line != *.min.css ]]; then
        continue
    fi
    if [[ "$line" =~ $srcRegex ]]; then
        ADJUSTED_LINE="$line"
        if [[ "$line" =~ $objectRegex && $FLAT_OBJECTS == "YES" ]]; then
            fileName=$(echo "$line" | sed "s:$filePathRegex:\2:g")
            ADJUSTED_LINE="src/Objects/$fileName"
        fi
        echo "Evaluating: $ADJUSTED_LINE"
        if ! test -f "$ADJUSTED_LINE"; then
            continue
        fi
        newLine=$(echo "$ADJUSTED_LINE" | sed "s/src\//\t<path>~\//")"$endOfLine"
        if [[ $OBJECTLINE == *"$newLine"* || $FILELINE == *"$newLine"* ]]; then
            continue
        fi

        ### File and Object Separation for deploy.xml
        # Differentiates and processes files and objects for deployment
        if [[ "$ADJUSTED_LINE" =~ $fileRegex ]]; then
            if [[ "$ADJUSTED_LINE" =~ $attributesRegex ]]; then
                continue
            fi
            FILELINE+="\t${newLine}"
        elif [[ "$ADJUSTED_LINE" =~ $objectRegex ]]; then
            while read OBJLINE; do
                if [[ "$OBJLINE" =~ $objectScriptPathRegex ]]; then
                    SCRIPTPATH=$(echo "$OBJLINE" | sed "s/<scriptfile>\[/\/src/")
                    SCRIPTPATH=$(echo "${SCRIPTPATH}" | sed "s/\]<\/scriptfile>//")
                    depLine=$(echo "${SCRIPTPATH}" | sed "s/\/src\//\t<path>~\/FileCabinet\//")"$endOfLine"
                    CLEANPATH=$(echo "$SCRIPTPATH" | sed "s/src\///")
                    regexLineStr=".*$CLEANPATH"
                    if [[ "$FILELINE" =~ $regexLineStr ]]; then
                        continue
                    fi
                    FILELINE+="\t${depLine}"
                fi
            done < <(cat "./${ADJUSTED_LINE}")
            echo "${ADJUSTED_LINE}" >>objectFileList.pipeline-test.txt
            OBJECTLINE+="\t${newLine}"
        fi
    fi
    line=""
done < <(git log --oneline --stat "$GIT_BRANCHES" --name-only)

## Deploy.xml Generation
### Constructing deploy.xml Based on File and Object Modifications
# Generates deploy.xml file with updated paths for files and objects based on git log
OUTPUTLINES=""
if [[ $FILELINE ]]; then
    echo "##vso[task.setvariable variable=RELEASE_BUILD]true"
    OUTPUTLINES="<files>\n${FILELINE}\t</files>"
fi
if [[ $OBJECTLINE ]]; then
    echo "##vso[task.setvariable variable=RELEASE_BUILD]true"
    OUTPUTLINES="${OUTPUTLINES}\n\t<objects>\n${OBJECTLINE}\t</objects>"
fi
echo "Writing Output"
printf "<deploy>
    <configuration>
        <path>~/AccountConfiguration/*</path>
    </configuration>
    ${OUTPUTLINES}
    <translationimports>
        <path>~/Translations/*</path>
    </translationimports>
</deploy>" >src/deploy.xml

## Log Output
### Displaying the Final deploy.xml for Verification
# Outputs the final content of deploy.xml for logging and verification purposes
cat src/deploy.xml
