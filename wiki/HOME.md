# 🚀 NetSuite SuiteScript Project Template: Module Testing & CI/CD Integration

## 🚀 Introduction

Welcome to the NetSuite SuiteScript Project Template - a cutting-edge solution tailored for module testing and CI/CD integration within the NetSuite ecosystem. This project is meticulously aligned with **NS 2023.2**, ensuring up-to-date compatibility and performance.

Designed to work seamlessly with the [NetSuite-Cust-Jest-Stubs-Template](https://github.com/devnetkc/NetSuite-Cust-Jest-Stubs-Template), this template stands as a pivotal tool for NetSuite developers. It facilitates the creation, testing, and deployment of custom SuiteScript modules, promoting efficiency and reliability in the development process.

### Core Features

- **SuiteScript Module Development:** Crafted specifically for SuiteScript, it acts as an essential starting point for scripting, adhering to NetSuite's best practices and standards.
- **Automated Module Testing:** Integrating Jest for automated testing, it ensures your SuiteScript modules function flawlessly, enhancing code reliability.
- **Custom Stub Integration:** Allows for the integration of custom Jest stubs, simulating NetSuite's API for isolated testing.
- **CI/CD Integration:** Comes with pre-configured Azure Pipeline configurations, automating the integration and deployment processes.
- **Documentation Generation:** Utilizes JSDoc comments and Markdown for automatic, detailed documentation of SuiteScript modules.

Local aliases for SuiteScript modules are effectively managed using the `/SuiteScript/...` path, ensuring compatibility with the NetSuite SuiteScript root directory `/SuiteScripts/`. This feature simplifies the management of scripts and aligns with NetSuite's directory structure.

### Targeted Use Cases

- **NetSuite SuiteScript Developers:** Ideal for crafting and managing custom scripts within NetSuite.
- **Quality Assurance and Testing:** Ensures rigorous testing routines for NetSuite customizations.
- **CI/CD Pipeline Integration:** Seamlessly integrates SuiteScript development into CI/CD workflows.
- **Documentation and Maintenance:** Automates documentation for easy maintenance and understanding of scripts.

Leverage this template to elevate your SuiteScript development workflow, ensuring robust, well-tested, and efficiently integrated scripts within your NetSuite environment.

## 🎉 Getting Started

1. Open [`./package.json`](./package.json) and customize the project configuration.
2. Add your `ExcludeStubs` path aliases to [`jest.config.js`](./jest.config.js).
3. Create a local environment variable `NPM_TOKEN` using your NPM token (variable name can be changed in [`.npmrc`](./.npmrc)).
4. Run `npm i` to install project dependencies.
5. Run `npm run generate-manifests` to create `deploy.xml` and `manifest.xml`, essential for SuiteCloud tools.
6. Setup SuiteCloud account details:
    - CLI (update `$()` variables with your values): `npm run setup-server --sourcebranch=$(SOURCEBRANCH) --headbranch=$(HEADBRANCH) --account=$(ACCOUNT) --authid=$(AUTHID) --tokenid=$(TOKENID) --tokensecret=$(TOKENSECRET)`
    - VSCode: Open command pallet (`CMD + SHIFT + p` on MacOS, `CTRL + SHIFT + p` on Windows), then select & run `SuiteCloud: Set Up Account`.

## 🧐 Notable Files

- [`manifest.tpl.xml`](./ci/templates/manifest.tpl.xml) - Template for SuiteCloud project manifest. (Project Name Change Required)
- [`README.hbs`](./.ci/templates/README.hbs) - Base template for generating project README.md.
- [`npmrc`](./.npmrc) - NPM environment token loader for publishing (variable name `NPM_TOKEN` can be changed).
- [`docsMD.config`](./.ci/config/docsMD.config.js) - Generator for Markdown documentation from JSDoc notations.
- [`jsDocsConf.json`](./.ci/config/jsDocsConf.json) - Configuration for JSDoc generation. Update `base_url` from `localhost` for hosted documentation.
- New scripts like `flattenObjectPath.sh`, `rmDependents.sh`, and `web.config.private` for improved project management.

## 🔨 Scripts

Use `npm run <script>` to execute various project commands:

- `npm run test` - Run tests using Jest. (See [Running Tests](#-running-tests) for details.)
- `npm run docs` - Generate project documentation from JSDoc notations (configure with [docsMD.config](./.ci/config/docsMD.config.js) & [jsDocsConf.json](./.ci/config/jsDocsConf.json)).
- `npm run open-docs` - Open documentation in a browser for viewing.
- `npm run generate-manifests` - Generate `deploy.xml` & `manifest.xml` for SuiteCloud.
- `npm run generate-manifests --headbranch=main --sourcebranch=dev` - Generate change-based `deploy.xml` & `manifest.xml`.

### ✅ Running Tests

- `npm run test` - Run Jest tests in `./__tests__`.
- `npm run test-ci` - Run Jest tests in CI mode, creating junit reports.
- `npm run test --watch=watch` - Run Jest tests in watch mode.
- `npm run view-coverage` - Run tests and open coverage report.

#### Wallaby.js

[![Wallaby.js](https://img.shields.io/badge/wallaby.js-powered-blue.svg?style=flat&logo=github)](https://wallabyjs.com/oss/)

Repository contributors can use the [Wallaby.js OSS License](https://wallabyjs.com/oss/) for immediate test results.

## 👷 CI/CD

Azure yaml pipeline files in [`.ci/workflows`](./.ci/workflows) are designed to automate and streamline the CI/CD processes for different deployment scenarios:

- [`azure-pipelines-docs.yml`](./.ci/workflows/azure-pipelines-docs.yml): Generates project documentation based on JSDoc comments, commits the changes, and pushes them back to the current PR or branch. This ensures that the documentation is always up-to-date with the codebase.
- [`azure-pipelines-build-deploy.yml`](./.ci/workflows/azure-pipelines-build-deploy.yml): Executes Jest tests, generates a change-based `deploy.xml`, updates manifest dependencies, and uses the SuiteCloud CLI to deploy the project to NetSuite. This pipeline ensures that only tested and verified changes are deployed.
- [`azure-pipelines-build-prod.yml`](./.ci/workflows/azure-pipelines-build-prod.yml): Tailored for production environment deployments. It validates production pull requests and creates a release for the main branch.
- [`azure-pipelines-build-sb.yml`](./.ci/workflows/azure-pipelines-build-sb.yml): Focused on deployments to a Sandbox 1 environment. It facilitates testing and validation in a sandbox before changes are moved to production.
- [`azure-pipelines-build-sb2.yml`](./.ci/workflows/azure-pipelines-build-sb2.yml): Similar to `azure-pipelines-build-sb.yml` but targets a Sandbox 2 environment, providing an additional layer of testing or for separate feature testing.
- [`azure-pipelines-select-branch.yml`](./.ci/workflows/azure-pipelines-select-branch.yml): Assists in determining the source branch for a pull request, ensuring that the correct branch is used for comparisons and deployments in CI/CD processes.
- [`azure-pipelines-validate-prod-pr.yml`](./.ci/workflows/azure-pipelines-validate-prod-pr.yml): Validates pull requests against the production branch, ensuring that only approved and compliant changes are merged.

These pipelines collectively support a robust and flexible CI/CD process, enabling automatic testing, documentation updates, and deployment to various environments, ensuring consistency and reliability in software delivery.


## 📝 Documentation

Comprehensive project documentation is available, detailing setup, configuration, and usage instructions.

## Modules

<dl>
<dt><a href="#module_csExampleModule_CS">csExampleModule_CS</a></dt>
<dd><p>Your custom NetSuite Client Script module</p>
</dd>
<dt><a href="#module_aModule">aModule</a></dt>
<dd><p>This is example custom NetSuite module A.  It may or may not be in your SuiteCloud project.
Update your <code>jest.config.js</code> to map this module from the stub pkg to your local project if it is available.
See project <code>jest.config.js</code> for further examples of this.</p>
</dd>
<dt><a href="#module_/SuiteScripts/Modules/aModule">/SuiteScripts/Modules/aModule</a></dt>
<dd><p>NetSuite module A export function</p>
</dd>
</dl>

## Functions

<dl>
<dt><a href="#exp_module_/SuiteScripts/CS/csExampleModule_CS--csExampleModule_CS">csExampleModule_CS(log, aModule, bModule)</a> ⏏</dt>
<dd><p>Custom NetSuite Client Script module export function</p>
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
<a name="module_aModule"></a>

## aModule
This is example custom NetSuite module A.  It may or may not be in your SuiteCloud project.
Update your `jest.config.js` to map this module from the stub pkg to your local project if it is available.
See project `jest.config.js` for further examples of this.

**Format**:   
**Napiversion**: 2.1  
**Since**: 2022.2  
**Version**: 1.0.0  
**License**: NApiVersion  
<a name="module_/SuiteScripts/Modules/aModule"></a>

## /SuiteScripts/Modules/aModule
NetSuite module A export function


| Param | Type | Description |
| --- | --- | --- |
| query | <code>Object</code> | NS query module |
| log | <code>Object</code> | NS log module |


* [/SuiteScripts/Modules/aModule](#module_/SuiteScripts/Modules/aModule)
    * [.GetVendorPrefix(vendorId)](#module_/SuiteScripts/Modules/aModule.GetVendorPrefix) ⇒ <code>String</code>
    * [.RunQuery(vendorId)](#module_/SuiteScripts/Modules/aModule.RunQuery) ⇒ <code>String</code>

<a name="module_/SuiteScripts/Modules/aModule.GetVendorPrefix"></a>

### /SuiteScripts/Modules/aModule.GetVendorPrefix(vendorId) ⇒ <code>String</code>
Returns preferred vendor prefix from record or blank if no prefix is located

**Kind**: static method of [<code>/SuiteScripts/Modules/aModule</code>](#module_/SuiteScripts/Modules/aModule)  

| Param | Type | Description |
| --- | --- | --- |
| vendorId | <code>String</code> | Entity ID of vendor Ex: `4321` |

<a name="module_/SuiteScripts/Modules/aModule.RunQuery"></a>

### /SuiteScripts/Modules/aModule.RunQuery(vendorId) ⇒ <code>String</code>
Returns query result of vendor prefix from vendor record

**Kind**: static method of [<code>/SuiteScripts/Modules/aModule</code>](#module_/SuiteScripts/Modules/aModule)  
**Returns**: <code>String</code> - - Returns vendor prefix string from query result  
**Access**: protected  

| Param | Type | Description |
| --- | --- | --- |
| vendorId | <code>String</code> | Vendor entity ID to run query on |


Happy Coding! 🥳