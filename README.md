# 🚀 Introduction

This project is meant to serve as a baseline template project for getting tests implemented easier in to your NetSuite SuiteCloud projects. This project demonstrates how to create and use:

-   Custom NetSuite modules
-   Test modules using Jest
-   Import your custom stubs package for Jest test
-   Integrate continuos integration/deployment pipelines for your project

This is currently based on **NS 2022.2**

This project pairs with the [NetSuite-Cust-Jest-Stubs-Template](https://github.com/devnetkc/NetSuite-Cust-Jest-Stubs-Template) tutorial/template npm package project.

Using the directory path `/SuiteScript/...`, we can provide aliases locally for these modules while still being available in NetSuite -- as the root directory for SuiteScript files in NetSuite is `/SuiteScripts/`.

## 🎉 Getting Started

1.  Open [`./package.json`](./package.json) and customize the project configuration
2.  Add your own `ExcludeStubs` path aliases to  [`jest.config.js`](./jest.config.js)
3.  Create a local environment variable `NPM_TOKEN` using your NPM token for the value _(Note: this variable name can be changed within the [`.npmrc`](./.npmrc) file)_
4.  Run `npm i` to install the project dependencies
5.  Run `npm run generate-manifests` to create local deploy.xml and manifest files **Required files to use SuiteCloud tools**
6.  Setup SuiteCloud account details
    -   CLI _(Note: update `$()` variables with your own values)_
        ```JS
        npm run setup-server --sourcebranch=$(SOURCEBRANCH) --headbranch=$(HEADBRANCH) --account=$(ACCOUNT) --authid=$(AUTHID) --tokenid=$(TOKENID) --tokensecret=$(TOKENSECRET)
        ```
    -   VSCode
        -   Open command pallet
            -   MacOS:`CMD + SHIFT + p` 
            -   Win: `CTRL + SHIFT + p`
        -   Select & Run `SuiteCloud: Set Up Account`

## 🧐 Notable Files

-   [`manifest.tpl.xml`](./ci/templates/manifest.tpl.xml) -- Used to create SuiteCloud project manifest (**Project Name Change Required**)
-   [`README.hbs`](./.ci/templates/README.hbs) -- Base template file the project README.md is generated from
-   [`npmrc`](./.npmrc) -- NPM environment token loader file for publishing project _(Note: the variable name `NPM_TOKEN` can be changed for multiple tokens)_
-   [`docsMD.config`](./.ci/config/docsMD.config.js) -- Wiki MD generator from JSDoc notations
-   [`jsDocsConf.json`](./.ci/config/jsDocsConf.json) -- JSDocs configuration file

## 🔨 Scripts

Use `npm run <script>` to execute various commands for the project

-   `npm run test` -- Uses Jest to run tests (see [Running Tests](#-running-tests) for more details.)
-   `npm run docs` -- Generates project documentation based on JSDoc notations (Configure with [docsMD.config](./.ci/config/docsMD.config.js) && [jsDocsConf.json](./.ci/config/jsDocsConf.json)) *(Note: also updates contributor list)*
-   `npm run open-docs` -- Opens documentation in browser for viewing
-   `npm run generate-manifests` -- Generates empty `deploy.xml` && `manifest.xml` in local project to satisfy SDF as being a SuiteCloud project
-   `npm run generate-manifests --headbranch=main --sourcebranch=dev` -- Generates change based `deploy.xml` && `manifest.xml` in local project based on source and head branch differences _(Note: script files referenced in changed Object files will be included in deploy.xml files if they exist, even if there was no changes made to them)_

### ✅ Running Tests

-   `npm run test` -- Uses Jest to run test files in `./__tests__` directory
-   `npm run test-ci` -- Uses Jest to run test files in `./__tests__` directory in CI mode creating junit report with it
-   `npm run test --watch=watch` -- Runs Jest tests in watch mode
-   `npm run view-coverage` -- Runs Jest tests and opens coverage report in browser window

#### Wallaby.js

[![Wallaby.js](https://img.shields.io/badge/wallaby.js-powered-blue.svg?style=flat&logo=github)](https://wallabyjs.com/oss/)

This repository contributors are welcome to use
[Wallaby.js OSS License](https://wallabyjs.com/oss/) to get
test results immediately as you type, and see the results in
your editor right next to your code.

## 👷 CI/CD

Azure yaml pipeline files are provided in [`.ci/workflows`](./.ci/workflows).

-   [`azure-pipelines-docs.yml`](./.ci/workflows/azure-pipelines-docs.yml) -- Generates documentation, commits,and pushes back to current PR/branch
-   [`azure-pipelines-build-deploy.yml`](./.ci/workflows/azure-pipelines-build-deploy.yml) -- Runs Jest tests, generates a change based deploy.xml, updates manifest dependencies, and uses SuiteCloud CLI to deploy projects



## 📝 Documentation

## Modules

<dl>
<dt><a href="#module_csExampleModule_CS">csExampleModule_CS</a></dt>
<dd><p>Your custom NetSuite Client Script module</p>
</dd>
<dt><a href="#module_aModule">aModule</a></dt>
<dd><p>Your custom NetSuite module A</p>
</dd>
</dl>

<a name="module_csExampleModule_CS"></a>

## csExampleModule\_CS
Your custom NetSuite Client Script module

**Summary**: This is example custom NetSuite Client Script module.  It may or may not be in your SuiteCloud project.
Update your `jest.config.js` to map this module from the stub pkg to your local project if it is available.
See project `jest.config.js` for further examples of this.  
**Format**:   
**Napiversion**: 2.1  
**Since**: 2022.2  
**Version**: 1.0.0  
**License**: NApiVersion  

* [csExampleModule_CS](#module_csExampleModule_CS)
    * [csExampleModule_CS(log, aModule, bModule)](#exp_module_csExampleModule_CS--csExampleModule_CS) ⏏
        * [.pageInit(scriptContext)](#module_csExampleModule_CS--csExampleModule_CS.pageInit) ⇒ <code>void</code>
        * [.saveRecord(scriptContext)](#module_csExampleModule_CS--csExampleModule_CS.saveRecord) ⇒ <code>boolean</code>

<a name="exp_module_csExampleModule_CS--csExampleModule_CS"></a>

### csExampleModule\_CS(log, aModule, bModule) ⏏
Custom NetSuite Client Script module export function

**Kind**: Exported function  

| Param | Type | Description |
| --- | --- | --- |
| log | <code>Object</code> | NS log module |
| aModule | <code>Object</code> | Custom NetSuite module A |
| bModule | <code>Object</code> | Custom NetSuite module B |

<a name="module_csExampleModule_CS--csExampleModule_CS.pageInit"></a>

#### csExampleModule_CS.pageInit(scriptContext) ⇒ <code>void</code>
Entry method for CS pageInit function

**Kind**: static method of [<code>csExampleModule\_CS</code>](#exp_module_csExampleModule_CS--csExampleModule_CS)  

| Param | Type | Description |
| --- | --- | --- |
| scriptContext | <code>Object</code> | Passed parameter for NetSuite CS pageInit entry function |
| scriptContext.currentRecord | <code>Record</code> | Current form record |

<a name="module_csExampleModule_CS--csExampleModule_CS.saveRecord"></a>

#### csExampleModule_CS.saveRecord(scriptContext) ⇒ <code>boolean</code>
Entry method for CS saveRecord function

**Kind**: static method of [<code>csExampleModule\_CS</code>](#exp_module_csExampleModule_CS--csExampleModule_CS)  
**Returns**: <code>boolean</code> - - Returns `false` if record should not save yet  

| Param | Type | Description |
| --- | --- | --- |
| scriptContext | <code>Object</code> | - Passed parameter for NetSuite CS saveRecord entry function |
| scriptContext.currentRecord | <code>Object</code> | - Current record being saved |

<a name="module_aModule"></a>

## aModule
Your custom NetSuite module A

**Summary**: This is example custom NetSuite module A.  It may or may not be in your SuiteCloud project.
Update your `jest.config.js` to map this module from the stub pkg to your local project if it is available.
See project `jest.config.js` for further examples of this.  
**Format**:   
**Napiversion**: 2.1  
**Since**: 2022.2  
**Version**: 1.0.0  
**License**: NApiVersion  

* [aModule](#module_aModule)
    * [aModule(query, log)](#exp_module_aModule--aModule) ⏏
        * [.GetVendorPrefix(vendorId)](#module_aModule--aModule.GetVendorPrefix) ⇒ <code>String</code>
        * [.RunQuery(vendorId)](#module_aModule--aModule.RunQuery) ⇒ <code>String</code>

<a name="exp_module_aModule--aModule"></a>

### aModule(query, log) ⏏
NetSuite module A export function

**Kind**: Exported function  

| Param | Type | Description |
| --- | --- | --- |
| query | <code>Object</code> | NS query module |
| log | <code>Object</code> | NS log module |

<a name="module_aModule--aModule.GetVendorPrefix"></a>

#### aModule.GetVendorPrefix(vendorId) ⇒ <code>String</code>
Returns preferred vendor prefix from record or blank if no prefix is located

**Kind**: static method of [<code>aModule</code>](#exp_module_aModule--aModule)  

| Param | Type | Description |
| --- | --- | --- |
| vendorId | <code>String</code> | Entity ID of vendor Ex: `4321` |

<a name="module_aModule--aModule.RunQuery"></a>

#### aModule.RunQuery(vendorId) ⇒ <code>String</code>
Returns query result of vendor prefix from vendor record

**Kind**: static method of [<code>aModule</code>](#exp_module_aModule--aModule)  
**Returns**: <code>String</code> - - Returns vendor prefix string from query result  
**Access**: protected  

| Param | Type | Description |
| --- | --- | --- |
| vendorId | <code>String</code> | Vendor entity ID to run query on |


Happy Coding! 🥳 
