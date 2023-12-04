#!/bin/bash

# Loop through all SCSS files in the specified directory
for input in src/FileCabinet/SuiteScripts/*.scss; do
    # Define the output file path by replacing the .scss extension with .min.css
    output="src/FileCabinet/SuiteScripts/$(basename "$input" .scss).min.css"

    # Compile the SCSS file to minified CSS using node-sass
    node-sass --output-style compressed "$input" "$output"

    # The resulting minified CSS is stored in the output file
done
