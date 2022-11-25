/** @format */

const SuiteCloudJestConfiguration = require('@oracle/suitecloud-unit-testing/jest-configuration/SuiteCloudJestConfiguration');
const cliConfig = require('./suitecloud.config');

const SuiteCloudJestStubs = require('suitecloud-unit-testing-stubs/SuiteCloudJestStubs');
// Load your npm custom module stub pkg
const CustomJestStubs = require('@vnetwork-solutions/ns-custom-stubs-template/customJestStubs');

const SuiteCloudJestCustomStubs = SuiteCloudJestStubs.customStubs;
// Add your custom stubs to SuiteCloudJestStubs
const MyCustomStubs = CustomJestStubs.customStubs;

// Here, you can control the paths for stubbed modules to their local file for Jest tests.
const ExcludeStubs = [
  {
    name: '/SuiteScripts/Modules/rQuery',
    path: `${__dirname}/src/FileCabinet`,
  },
];
const TestArray = SuiteCloudJestCustomStubs.concat(MyCustomStubs(ExcludeStubs)); //?
//SuiteCloudJestCustomStubs.push(cfmCustomStubs); //?

module.exports = SuiteCloudJestConfiguration.build({
  testResultsProcessor: './node_modules/jest-junit-reporter',
  projectFolder: cliConfig.defaultProjectFolder,
  projectType: SuiteCloudJestConfiguration.ProjectType.ACP,
  customStubs: TestArray,
  testPathIgnorePatterns: [
    '(/__tests__/.*|(\\.|/)(test|spec))\\.[jt]sx?$',
    '**.*\\.min\\.*',
  ],
});
