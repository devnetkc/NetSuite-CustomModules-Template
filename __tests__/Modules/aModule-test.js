/**
 * @format
 * @module customModule_CS-test
 */

import log from 'N/log';
import query from 'N/query';
import aModule from '/SuiteScripts/Modules/aModule';

jest.mock('N/log');
jest.mock('N/query');

beforeEach(() => {
  jest.clearAllMocks();
});

// eslint-disable-next-line import/no-amd
describe('aModule.js', () => {
  describe('test exec GetVendorPrefix', () => {
    // * GIVEN
    jest.spyOn(query, 'runSuiteQL').mockImplementation(queryObj => {
      const VendorId = queryObj.query.replace(/.*= (.*)/, '$1');
      const Prefixes = {
        55321: 'JD-',
        55322: 'AJ-',
      };
      return { prefix: Prefixes[VendorId] };
    });
    test('should not throw any errors', () => {
      // * GIVEN
      const VendorId = '55321';
      // * WHEN
      const ExecGetVendorPrefix = aModule.GetVendorPrefix(VendorId);
      // * THEN
      expect(() => {
        ExecGetVendorPrefix;
      }).not.toThrow();
    });
    test('Should be JD- when VendorId == 55321', () => {
      // * GIVEN
      const VendorId = '55321';
      // * WHEN
      const ExecGetVendorPrefix = aModule.GetVendorPrefix(VendorId);
      // * THEN
      expect(ExecGetVendorPrefix).toBe('JD-');
    });
    test('Should be AJ- when VendorId == 55322', () => {
      // * GIVEN
      const VendorId = '55322';
      // * WHEN
      const ExecGetVendorPrefix = aModule.GetVendorPrefix(VendorId);
      // * THEN
      expect(ExecGetVendorPrefix).toBe('AJ-');
    });
  });
  describe('test exec RunQuery', () => {
    // * GIVEN
    jest.spyOn(query, 'runSuiteQL').mockImplementation(queryObj => {
      const VendorId = queryObj.query.replace(/.*= (.*)/, '$1');
      const Prefixes = {
        55321: 'JD-',
        55322: 'AJ-',
      };
      return { prefix: Prefixes[VendorId] };
    });
    test('should not throw any errors', () => {
      // * GIVEN
      const VendorId = '55321';
      // * WHEN
      const ExecGetVendorPrefix = aModule.GetVendorPrefix(VendorId);
      // * THEN
      expect(() => {
        ExecGetVendorPrefix;
      }).not.toThrow();
    });
    test('Should be JD- when VendorId == 55321', () => {
      // * GIVEN
      const VendorId = '55321';
      // * WHEN
      const ExecGetVendorPrefix = aModule.GetVendorPrefix(VendorId);
      // * THEN
      expect(ExecGetVendorPrefix).toBe('JD-');
    });
  });
});
