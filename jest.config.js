/**
 * @format
 * @name JestConfig
 * @description Jest config file for project. This file can be modified for simplicity
 *              based on project requirements. Areas for potential simplification are noted below.
 * @exports BuildJestConfig
 */

const SuiteCloudJestConfiguration = require('@oracle/suitecloud-unit-testing/jest-configuration/SuiteCloudJestConfiguration');
const cliConfig = require('./suitecloud.config');

const SuiteCloudJestStubs = require('suitecloud-unit-testing-stubs/SuiteCloudJestStubs');
// Load your npm custom module stub pkg
// Note: This can be omitted for simpler projects that do not require additional custom stubs.
const CustomJestStubs = require('@vnetwork-solutions/ns-custom-stubs-template/customJestStubs');

// Add your custom stubs to SuiteCloudJestStubs
// Note: For minimal configurations, you can directly use SuiteCloudJestCustomStubs without MyCustomStubs.
const MyCustomStubs = CustomJestStubs.customStubs;
// Load custom module paths for Jest
const ModulePaths = require('./.ci/config/jest/modulePaths.min');

const SuiteCloudJestCustomStubs = SuiteCloudJestStubs.customStubs;

/**
 * @typedef UseMinified
 * @type {Object}
 * @description Options for loading minified file
 * @property {boolean} value - T/F do you want to use a minified version in define statement
 * @property {String} minName='.min' - Optional alternative post fix identifier to add to file
 */
/**
 * @typedef ExcludeStub
 * @type {Object}
 * @property {String} name - "Directory/Path/ModuleName" -- CustomStub property to use
 * @property {String} path - Path to module for project -- generally you will use `\`${__dirname}/src/FileCabinet\``
 * @property {UseMinified} useMinified - Options for using or not using minified files locally
 * @description Array of module names and paths to use for them in the stubs package
 * @summary Here, you can control the paths for stubbed modules to their local file for Jest tests.
 */
/**
 * @name ExcludeStubs
 * @type {ExcludeStub[]}
 * @description Array of modules from stub pkg to override with local version
 * Note: For a minimal configuration, this array can be empty or removed if not needed.
 */
const ExcludeStubs = [
  {
    name: '/SuiteScripts/Modules/aModule',
    path: `${__dirname}/src/FileCabinet`,
    useMinified: {
      value: false,
    },
  },
];

/**
 * @name BuildJestConfig
 * @function
 * @description Builds Jest config file using stubs and SuiteCloud config
 * Merge custom module paths with SuiteCloud custom stubs
 * @since 2022.2
 */
const BuildJestConfig = SuiteCloudJestConfiguration.build({
  testResultsProcessor: './node_modules/jest-junit-reporter',
  projectFolder: cliConfig.defaultProjectFolder,
  projectType: SuiteCloudJestConfiguration.ProjectType.ACP,
  customStubs: SuiteCloudJestCustomStubs.concat(
    ModulePaths.CustomModulePaths
  ).concat(
    // Note: For simpler projects, you can remove MyCustomStubs(ExcludeStubs) concatenation.
    MyCustomStubs(ExcludeStubs)
  ),
  testPathIgnorePatterns: [
    '(/__tests__/.*|(\\.|/)(test|spec))\\.[jt]sx?$',
    '**.*\\.min\\.*',
  ],
  collectCoverageFrom: [
    // Note: Coverage collection can be simplified or omitted based on project needs.
    '**/*.{js,jsx}',
    '!**/node_modules/**',
    '!**/__tests__/**',
    '!**/**min.js',
  ],
  moduleDirectories: ['node_modules'],
  modulePaths: [
    '<rootDir>',
    '<rootDir>/node_modules',
    '<rootDir>/src/FileCabinet',
  ],
  testEnvironment: 'jsdom',
});

module.exports = BuildJestConfig;
