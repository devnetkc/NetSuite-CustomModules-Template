/**
 * @format
 * @namespace NetSuite
 * @ignore
 *
 * @file suitecloud.config.js
 * @module suitecloud-config
 * @description This configuration file is integral to NetSuite SuiteCloud projects.
 * It primarily sets up project-specific parameters and customizes behaviors for various
 * SuiteCloud commands. Notably, it includes configurations for the 'project:deploy' command,
 * providing a mechanism to modify command execution, such as excluding Jest tests during
 * certain stages of deployment. This exclusion is crucial, as Jest tests are typically run
 * earlier or in a separate continuous integration pipeline.
 *
 * The file also serves as a reference point for organizing different types of SuiteScript
 * modules such as Client Scripts, User Event Scripts, and Scheduled Scripts within the
 * NetSuite SuiteScript 2.x development framework. These modules are categorized under
 * relevant namespaces, aiding in the structured documentation of the project and
 * enhancing the maintainability and navigability of the codebase. The use of namespaces
 * here reflects an organizational method for documentation purposes, providing a clear
 * and concise categorization of script types within the broader NetSuite ecosystem.
 */

const SuiteCloudJestUnitTestRunner = require('@oracle/suitecloud-unit-testing/services/SuiteCloudJestUnitTestRunner');

module.exports = {
  defaultProjectFolder: 'src',
  commands: {
    'project:deploy': {
      beforeExecuting: async args => {
        // We do not run Jest tests here...
        // We execute before getting to this stage of deployment
        // We also encourage doing this in the pipeline on its own now as well
        return args;
      },
    },
  },
};
/**
 * @namespace NetSuite.ClientScripts
 * @memberof NetSuite
 * @description Series of custom Client Script modules
 */
/**
 * @namespace NetSuite.UserEventScripts
 * @memberof NetSuite
 * @description Series of custom User Event Script modules
 */
/**
 * @namespace NetSuite.ScheduledScripts
 * @memberof NetSuite
 * @description Series of custom Scheduled Script modules
 */
