/** @format
 *  @memberof SuiteCloud
 */

const SuiteCloudJestUnitTestRunner = require('@oracle/suitecloud-unit-testing/services/SuiteCloudJestUnitTestRunner');
//const exec = require('child_process').exec;

module.exports = {
  defaultProjectFolder: 'src',
  commands: {
    'project:deploy': {
      beforeExecuting: async args => {
        // We do not run Jest tests here...
        // We execute before getting to this stage of deployment
        return args;
      },
    },
  },
};
