/**
 * @format
 * @module aModule
 * @description Your custom NetSuite module A
 * @version 1.0.0
 * @NApiVersion 2.1
 * @preserve NApiVersion
 * @since 2022.2
 */
(() => {
  /**
   * @name Dependencies
   * @memberof module:aModule
   * @type {Array}
   * @description Array of dependencies the module requires
   * @ignore
   */
  const Dependencies = ['N/query', 'N/log'];
  //AMD & CommonJS compatibility stuff
  // CommonJS
  if (typeof module !== 'undefined' && typeof require !== 'undefined') {
    // Set ID for identifying in Jest
    module.id = '/SuiteScripts/Modules/aModule';
    module.exports = aModule.apply(this, Dependencies.map(require));
    module.exports.mockable = aModule; // module loader with mockable dependencies
  }
  // AMD
  if (typeof define !== 'undefined') {
    define(Dependencies, aModule);
  }
})();

/**
 * @alias module:aModule
 * @description NetSuite module A export function
 * @param {Object} query - NS query module
 * @param {Object} log - NS log module
 */
function aModule(query, log) {
  /**
   * @name GetVendorPrefix
   * @description Returns preferred vendor prefix from record or blank if no prefix is located
   * @function
   * @memberof module:aModule
   * @param {String} itemName - Name of item Ex: `JD-4321`
   * @return {String}
   */
  const GetVendorPrefix = itemName => {
    // Example response
    return itemName.search(PrefixRegex(`..`));
  };
  /**
   * @name EmployeeCount
   * @memberof module:aModule
   * @description Returns number of employees in a given department
   * @function
   * @param {String} department - Department to get number of employees from
   * @return {Object}
   */
  const EmployeeCount = department => {};
  /**
   * @name PrefixRegex
   * @memberof module:aModule
   * @description Returns regex object for finding a prefix in a string
   * @function
   * @param {String} characters - Regex pattern to match before `-` for prefix
   * @return {Object}
   */
  const PrefixRegex = characters => {
    return new RegExp(`^(${characters})-`);
  };
  // * This is for Jest to have direct access to all methods for running tests
  if (typeof module !== 'undefined' && typeof require !== 'undefined') {
    return {
      GetVendorPrefix,
      PrefixRegex,
      EmployeeCount,
    };
  }
  // * These methods are returned in NetSuite
  return {
    EmployeeCount,
  };
}
