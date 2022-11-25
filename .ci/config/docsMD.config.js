/** @format */

const jsdoc2md = require('jsdoc-to-markdown');
const fs = require('fs');
const path = require('path');

/* input and output paths */
const inputFile = './src/**/*[^.min].js';
const outputDir = __dirname;

/* get template data */
const templateData = jsdoc2md.getTemplateDataSync({ files: inputFile });

/* reduce templateData to an array of class names */
const classNames = templateData.reduce((classNames, identifier) => {
  if (identifier.kind === 'class') classNames.push(identifier.name);
  return classNames;
}, []);

/* create a documentation file for each class */
for (const className of classNames) {
  const template = `{{#class name="${className}"}}{{>docs}}{{/class}}`;
  console.log(`rendering ${className}, template: ${template}`);
  const output = jsdoc2md.renderSync({
    data: templateData,
    template: template,
  });
  const FileName = `wiki/${className}.md`;
  const FilePath = path.resolve(outputDir, `${FileName}`);
  fs.exists(FilePath, exists => {
    if (!exists) {
      // Create a file
      return fs.writeFile(FilePath, output, () => {});
    }
    fs.writeFileSync(FilePath, output);
  });
}

fs.copyFile('README.md', 'wiki/README.md', () => {});
