/**
 * @format
 * @module aModule
 * @version 1.0.0
 * @NApiVersion 2.1
 * @preserve NApiVersion
 * @since 2022.2
 * @description This is example custom NetSuite module A.  It may or may not be in your SuiteCloud project.
 * Update your `jest.config.js` to map this module from the stub pkg to your local project if it is available.
 * See project `jest.config.js` for further examples of this.
 */
(() => {
  /**
   * @name Dependencies
   * @memberof module:/SuiteScripts/Modules/aModule
   * @type {Array}
   * @description Array of dependencies the module requires
   * @ignore
   */
  const Dependencies = ['N/query', 'N/log'];
  //AMD & CommonJS compatibility stuff
  // CommonJS
  /* istanbul ignore else */
  if (typeof module !== 'undefined' && typeof require !== 'undefined') {
    // Set ID for identifying in Jest
    module.id = '/SuiteScripts/Modules/aModule';
    module.exports = aModule.apply(this, Dependencies.map(require));
    module.exports.mockable = aModule; // module loader with mockable dependencies
  }
  // AMD
  /* istanbul ignore next */
  if (typeof define !== 'undefined') {
    /* istanbul ignore next */
    define(Dependencies, aModule);
  }
})();

/**
 * @module module:/SuiteScripts/Modules/aModule
 * @description NetSuite module A export function
 * @param {Object} query - NS query module
 * @param {Object} log - NS log module
 */
function aModule(query, log) {
  /**
   * @name GetVendorPrefix
   * @description Returns preferred vendor prefix from record or blank if no prefix is located
   * @function
   * @memberof module:/SuiteScripts/Modules/aModule
   * @param {String} vendorId - Entity ID of vendor Ex: `4321`
   * @return {String}
   */ const GetVendorPrefix = vendorId => {
    const VendorPrefix = RunQuery(vendorId);
    // Example response
    return VendorPrefix;
  };
  /**
   * @name RunQuery
   * @memberof module:/SuiteScripts/Modules/aModule
   * @description Returns query result of vendor prefix from vendor record
   * @function
   * @protected
   * @param {String} vendorId - Vendor entity ID to run query on
   * @return {String} - Returns vendor prefix string from query result
   */
  const RunQuery = vendorId => {
    // Sample use of NS query module
    const QueryResult = query.runSuiteQL({
      query: `SELECT vendor.prefix FROM vendor WHERE vendor.entityid = ${vendorId}`,
    });
    return QueryResult.prefix;
  };
  // * This is for Jest to have direct access to all methods for running tests
  /* istanbul ignore else */
  if (typeof module !== 'undefined' && typeof require !== 'undefined') {
    return {
      GetVendorPrefix,
      RunQuery,
    };
  }
  // * These methods are returned in NetSuite
  /* istanbul ignore next */
  return {
    GetVendorPrefix,
  };
}
