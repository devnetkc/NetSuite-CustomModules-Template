/**
 * @format
 * Custom Module Paths for Jest Testing in NetSuite SuiteCloud Projects
 *
 * Purpose:
 * This file defines a mapping between SuiteScript modules and their corresponding file paths
 * within the project structure. It is used in Jest testing to resolve SuiteScript module imports
 * that would otherwise not be recognized in the Jest environment.
 *
 * How It Works:
 * - Each object in the CustomModulePaths array represents a mapping between a SuiteScript module
 *   (as used in NetSuite) and its equivalent local file path.
 * - 'module' key specifies the SuiteScript module path as it is referred to in the SuiteScript files.
 * - 'path' key provides the actual file path relative to the root directory of the project.
 * - This mapping allows Jest to correctly locate and import SuiteScript modules during tests.
 *
 * Integration with Jest:
 * - This mapping is imported into the Jest configuration (jest.config.js) under 'customStubs'.
 * - It enables Jest to understand and resolve the custom module paths specific to SuiteCloud projects,
 *   facilitating the testing of SuiteScript modules with Jest.
 *
 * Example Format:
 * - Suppose a SuiteScript module is located at 'src/FileCabinet/SuiteScripts/Modules/aModule.js'
 *   and is referred to in SuiteScripts as '/SuiteScripts/Modules/aModule'.
 * - The mapping object would be:
 *   {
 *     module: '/SuiteScripts/Modules/aModule',
 *     path: '<rootDir>src/FileCabinet/SuiteScripts/Modules/aModule.js',
 *   }
 * - This tells Jest that whenever '/SuiteScripts/Modules/aModule' is imported in a test,
 *   it should actually load from the specified path in the project directory.
 */

const CustomModulePaths = [
  {
    module: '/SuiteScripts/Modules/aModule',
    path: '<rootDir>src/FileCabinet/SuiteScripts/Modules/aModule',
  },
  {
    module: '/SuiteScripts/Modules/aModule.min',
    path: '<rootDir>src/FileCabinet/SuiteScripts/Modules/aModule.js',
  },
  {
    module: '/SuiteScripts/CS/customModule_CS',
    path: '<rootDir>src/FileCabinet/SuiteScripts/CS/customModule_CS',
  },
  {
    module: '/SuiteScripts/CS/customModule_CS.min',
    path: '<rootDir>src/FileCabinet/SuiteScripts/CS/customModule_CS.js',
  },
];
module.exports = {
  CustomModulePaths,
};
