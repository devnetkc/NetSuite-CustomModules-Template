/**
 * @format
 * @module customModule_CS-test
 */

import log from 'N/log';
import record from 'N/record';
import query from 'N/query';
import aModule from '/SuiteScripts/Modules/aModule.min';
import bModule from '/SuiteScripts/Modules/bModule.min';

jest.mock('N/log');
jest.mock('N/record');
jest.mock('N/query');
jest.mock('/SuiteScripts/Modules/bModule.min');

//import aModule from '/SuiteScripts/Modules/aModule';
import customModule_CS from './../../src/FileCabinet/SuiteScripts/CS/customModule_CS';

beforeEach(() => {
  jest.clearAllMocks();
});

// eslint-disable-next-line import/no-amd
describe('customModule_CS.js', () => {
  // Create our record obj to use
  const RecordObj = new record.Record();
  describe('test pageInit', () => {
    const Prefixes = {
      55321: 'JD-',
      55322: 'AJ-',
    };
    jest.spyOn(aModule, 'GetVendorPrefix').mockImplementation(vendorId => {
      return Prefixes[vendorId];
    });
    jest.spyOn(query, 'runSuiteQL').mockImplementation(vendorId => {
      return Prefixes[vendorId];
    });
    // * GIVEN
    const ErrorSpy = jest.spyOn(log, 'error');
    const ScriptContext = { currentRecord: RecordObj };
    describe('pageInit error handling', () => {
      // * GIVEN
      test('should catch any errors', () => {
        // * WHEN
        const ExecPageInit = customModule_CS.pageInit(ScriptContext);
        // * THEN
        expect(() => {
          ExecPageInit;
        }).not.toThrow();
      });
      test('should catch error when currentRecord property is not available', () => {
        // * WHEN
        const ExecPageInit = customModule_CS.pageInit({});
        // * THEN
        expect(() => {
          ExecPageInit;
        }).not.toThrow();
        expect(ErrorSpy).toHaveBeenCalledTimes(1);
      });
    });
    test('should call set_CustomFieldValue using bModule', () => {
      // * GIVEN
      const SetValueSpy = jest.spyOn(bModule, 'set_CustomFieldValue');
      // * WHEN
      customModule_CS.pageInit(ScriptContext);
      // * THEN
      expect(SetValueSpy).toHaveBeenCalledTimes(1);
    });
    test('should run 2 log audits & 1 debug log', () => {
      // * GIVEN
      const AuditSpy = jest.spyOn(log, 'audit');
      const DebugSpy = jest.spyOn(log, 'debug');
      const GetVendorPrefixLogDetails = {
        title: `Vendor Prefix Set`,
        details: { VendorPrefix: Prefixes[55321] },
      };
      // * WHEN
      customModule_CS.pageInit(ScriptContext);
      // * THEN
      expect(AuditSpy).toHaveBeenCalledTimes(2);
      expect(DebugSpy).toHaveBeenCalledTimes(1);
      expect(DebugSpy).toHaveBeenCalledWith(GetVendorPrefixLogDetails);
      expect(ErrorSpy).toHaveBeenCalledTimes(0);
    });
    test('Should call GetVendorPrefix from aModule', () => {
      // * GIVEN
      const aModuleSpy = jest.spyOn(aModule, 'GetVendorPrefix');
      // * WHEN
      customModule_CS.pageInit(ScriptContext);
      // * THEN
      expect(aModuleSpy).toHaveBeenCalledTimes(1);
    });
  });
});
