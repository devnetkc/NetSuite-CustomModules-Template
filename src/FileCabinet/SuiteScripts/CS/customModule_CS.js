/**
 * @format
 * @module csExampleModule_CS
 * @description Your custom NetSuite Client Script module
 * @version 1.0.0
 * @NApiVersion 2.1
 * @preserve NApiVersion
 * @since 2022.2
 * @summary This is example custom NetSuite Client Script module.  It may or may not be in your SuiteCloud project.
 * Update your `jest.config.js` to map this module from the stub pkg to your local project if it is available.
 * See project `jest.config.js` for further examples of this.
 */
(() => {
  /**
   * @name Dependencies
   * @memberof module:csExampleModule_CS
   * @type {Array}
   * @description Array of dependencies the client script module requires
   * @ignore
   */
  const Dependencies = [
    'N/log',
    '/SuiteScripts/Modules/aModule.min',
    '/SuiteScripts/Modules/bModule.min' /* Note we are loading the minified dependency here */,
  ];
  //AMD & CommonJS compatibility stuff
  // CommonJS
  if (typeof module !== 'undefined' && typeof require !== 'undefined') {
    // Set ID for identifying in Jest
    module.id = '/SuiteScripts/CS/csExampleModule_CS';
    module.exports = csExampleModule_CS.apply(this, Dependencies.map(require));
    module.exports.mockable = csExampleModule_CS; // module loader with mockable dependencies
  }
  // AMD
  if (typeof define !== 'undefined') {
    define(Dependencies, csExampleModule_CS);
  }
})();

/**
 * @alias module:csExampleModule_CS
 * @description Custom NetSuite Client Script module export function
 * @param {Object} log - NS log module
 * @param {Object} aModule - Custom NetSuite module A
 * @param {Object} bModule - Custom NetSuite module B
 */
function csExampleModule_CS(log, aModule, bModule) {
  /**
   * @name pageInit
   * @memberof module:csExampleModule_CS
   * @function
   * @param  {Object} scriptContext - Passed parameter for NetSuite CS pageInit entry function
   * @param {Record} scriptContext.currentRecord - Current form record
   * @description Entry method for CS pageInit function
   * @return {void}
   */
  const pageInit = scriptContext => {
    try {
      log.audit('starting custom client script pageInit');
      const VendorPrefix = aModule.GetVendorPrefix('55321');
      log.debug({ title: `Vendor Prefix Set`, details: { VendorPrefix } });
      if (!scriptContext.hasOwnProperty('currentRecord'))
        throw 'MISSING_RECORD_PROPERTY';
      bModule.set_CustomFieldValue(scriptContext.currentRecord, VendorPrefix);
      log.audit(`Vendor prefix saved`);
    } catch (err) {
      log.error({ title: 'csExampleModule_CS.pageInit()', details: err });
    }
  };
  /**
   * @name saveRecord
   * @memberof module:csExampleModule_CS
   * @function
   * @param  {Object} scriptContext -- Passed parameter for NetSuite CS saveRecord entry function
   * @description Entry method for CS saveRecord function
   * @return {boolean} - Returns `false` if record should not save yet
   */
  const saveRecord = scriptContext => {
    let allowSave = true;
    try {
      log.audit('starting custom client script saveRecord');
      // Run code to see if...
      // allowSave = false;
    } catch (err) {
      log.error({ title: 'csExampleModule_CS.saveRecord()', details: err });
    }
    return allowSave;
  };

  return {
    pageInit,
    saveRecord,
  };
}
