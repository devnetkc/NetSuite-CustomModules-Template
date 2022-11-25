# Introduction

This project is meant to serve as a baseline template project for getting tests implemented easier in to your NetSuite projects. Use these stubs for modules which are imported to other NetSuite SuiteCloud projects.

Using the directory path `/SuiteScript/...`, we can provide aliases locally for these modules while still being available in NetSuite -- as the root directory for SuiteScript files in NetSuite is `/SuiteScripts/`.

## 🎉 Getting Started

1. Open [`./package.json](./package.json) and customize the project configuration
2. Run `npm i` to install project dependencies
3. Add your module path aliases to [`customJestStubs.js`](./customJestStubs.js)
4. Create a local environment variable `NPM_TOKEN` using your NPM token for the value
5. Publish your npm package using `npm publish`

## 🧐 Notable Files

- [README.hbs](./.ci/templates/README.hbs) -- Base template file the project README.md is generated from
- [npmrc](./.npmrc) -- NPM environment token loader file for publishing project
- [docsMD.config](./.ci/config/docsMD.config.js) -- Wiki MD generator from JSDoc notations
- [jsDocsConf.json](./.ci/config/jsDocsConf.json) -- JSDocs configuration file

## 🔨 Scripts

Use `npm run <script>` to execute various commands for the project

- `npm run test` -- Uses Jest to run tests (see [Running Tests](#-running-tests) for more details.)
- `npm run docs` -- Generates project documentation based on JSDoc notations (Configure with [docsMD.config](./.ci/config/docsMD.config.js) && [jsDocsConf.json](./.ci/config/jsDocsConf.json))
- `npm run open-docs` -- Opens documentation in browser for viewing

### ✅ Running Tests

- `npm run test` -- Uses Jest to run test files in `./__tests__` directory
- `npm run test-ci` -- Uses Jest to run test files in `./__tests__` directory in CI mode creating junit report with it
- `npm run test --watch=watch` -- Runs Jest tests in watch mode
- `npm run view-coverage` -- Runs Jest tests and opens coverage report in browser window

## 👷 CI/CD

Azure yaml pipeline files are provided in [`.ci/workflows`](./.ci/workflows).

- [`azure-pipelines-docs.yml`](./.ci/workflows/azure-pipelines-docs.yml) -- Generates documentation, commits,and pushes back to current PR/branch

## Modules

<dl>
<dt><a href="#module_aModule">aModule</a></dt>
<dd><p>Your custom NetSuite module A</p>
</dd>
<dt><a href="#module_bModule">bModule</a></dt>
<dd><p>Your custom NetSuite module B</p>
</dd>
</dl>

<a name="module_aModule"></a>

## aModule
Your custom NetSuite module A

**Format**:   
**Napiversion**: 2.1  
**Since**: 2022.2  
**Version**: 1.0.0  
**License**: NApiVersion  

* [aModule](#module_aModule)
    * [aModule(query, log)](#exp_module_aModule--aModule) ⏏
        * [.GetVendorPrefix(itemName)](#module_aModule--aModule.GetVendorPrefix) ⇒ <code>String</code>
        * [.EmployeeCount(department)](#module_aModule--aModule.EmployeeCount) ⇒ <code>Object</code>
        * [.PrefixRegex(characters)](#module_aModule--aModule.PrefixRegex) ⇒ <code>Object</code>

<a name="exp_module_aModule--aModule"></a>

### aModule(query, log) ⏏
NetSuite module A export function

**Kind**: Exported function  

| Param | Type | Description |
| --- | --- | --- |
| query | <code>Object</code> | NS query module |
| log | <code>Object</code> | NS log module |

<a name="module_aModule--aModule.GetVendorPrefix"></a>

#### aModule.GetVendorPrefix(itemName) ⇒ <code>String</code>
Returns preferred vendor prefix from record or blank if no prefix is located

**Kind**: static method of [<code>aModule</code>](#exp_module_aModule--aModule)  

| Param | Type | Description |
| --- | --- | --- |
| itemName | <code>String</code> | Name of item Ex: `JD-4321` |

<a name="module_aModule--aModule.EmployeeCount"></a>

#### aModule.EmployeeCount(department) ⇒ <code>Object</code>
Returns number of employees in a given department

**Kind**: static method of [<code>aModule</code>](#exp_module_aModule--aModule)  

| Param | Type | Description |
| --- | --- | --- |
| department | <code>String</code> | Department to get number of employees from |

<a name="module_aModule--aModule.PrefixRegex"></a>

#### aModule.PrefixRegex(characters) ⇒ <code>Object</code>
Returns regex object for finding a prefix in a string

**Kind**: static method of [<code>aModule</code>](#exp_module_aModule--aModule)  

| Param | Type | Description |
| --- | --- | --- |
| characters | <code>String</code> | Regex pattern to match before `-` for prefix |

<a name="module_bModule"></a>

## bModule
Your custom NetSuite module B

**Format**:   
**Napiversion**: 2.1  
**Since**: 2022.2  
**Version**: 1.0.0  
**License**: NApiVersion  

* [bModule](#module_bModule)
    * [bModule(log)](#exp_module_bModule--bModule) ⏏
        * [.get_vendorPrefixB(recordObj)](#module_bModule--bModule.get_vendorPrefixB) ⇒ <code>String</code>

<a name="exp_module_bModule--bModule"></a>

### bModule(log) ⏏
NetSuite module B export function

**Kind**: Exported function  

| Param | Type | Description |
| --- | --- | --- |
| log | <code>Object</code> | NS log module |

<a name="module_bModule--bModule.get_vendorPrefixB"></a>

#### bModule.get\_vendorPrefixB(recordObj) ⇒ <code>String</code>
Returns preferred vendor prefix from record or blank if no prefix is located

**Kind**: static method of [<code>bModule</code>](#exp_module_bModule--bModule)  

| Param | Type | Description |
| --- | --- | --- |
| recordObj | <code>Record</code> | NS Record Object to update |


Happy Coding!
