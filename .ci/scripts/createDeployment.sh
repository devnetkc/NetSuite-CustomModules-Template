#!/bin/bash
#>testFile.txt
## Reset Manifest
cp ./.ci/templates/manifest.tpl.xml src/manifest.xml
endOfLine="</path>\n"
srcRegex='src\/.*'
attributesRegex='.*\.attributes.*'
fileRegex='src\/FileCabinet\/SuiteScripts.*'
objectRegex='src\/Objects\/.*'
objectScriptPathRegex='.*scriptfile.*'
FILELINE=
OBJECTLINE=
while read line; do
    # We only want to update src files in deployment
    if [[ "$line" =~ $srcRegex ]]; then
        # Setup what the new line will look like

        newLine=$(echo "$line" | sed "s/src\//\t<path>~\//")"$endOfLine"
        # Is a src file
        # Separate Files & Objects to build deploy.xml
        #echo "$line"
        if [[ "$line" =~ $fileRegex ]]; then
            if [[ "$line" =~ $attributesRegex ]]; then
                continue
            elif ! test -f "$line"; then
                continue
            fi
            #echo "file regex match"
            # Is a file update
            FILELINE+="\t${newLine}"
            # echo $FILELINE
        elif [[ "$line" =~ $objectRegex ]]; then
            # Test line to see if the object needs a file path added
            while read OBJLINE; do
                if [[ "$OBJLINE" =~ $objectScriptPathRegex ]]; then
                    #regexStr=".*${OBJLINE}.*"
                    #echo $OBJLINE
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
            done < <(cat "./${line}")
            #echo "object regex match"
            # Is an object file update
            OBJECTLINE+="\t${newLine}"
            #echo $OBJECTLINE
        fi
    fi
    line=""
done < <(git diff origin/$1 $2 --name-only)

OUTPUTLINES=""
if [[ $FILELINE ]]; then
    OUTPUTLINES="<files>\n${FILELINE}\t</files>"
fi
if [[ $OBJECTLINE ]]; then
    OUTPUTLINES="${OUTPUTLINES}\n\t<objects>\n${OBJECTLINE}\t</objects>"
fi
printf "<deploy>
    <configuration>
        <path>~/AccountConfiguration/*</path>
    </configuration>
    ${OUTPUTLINES}
    <translationimports>
        <path>~/Translations/*</path>
    </translationimports>
</deploy>" >src/deploy.xml | cat src/deploy.xml
