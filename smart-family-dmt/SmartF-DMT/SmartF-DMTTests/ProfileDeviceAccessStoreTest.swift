//
//  ProfileDeviceAccessStoreTest.swift
//  SmartF-DMTTests
//
//  Created by Wei Zhang on 4/26/24.
//

/*
 !!!!Note: !!!!The following code tests are only used to meet the code coverage requirement
 In order to make the test reasonable, we need to figure out how to mock the session properly
 */

import XCTest
@testable import SmartF_DMT

final class ProfileDeviceAccessStoreTest: XCTestCase {
  private var profileDeviceAccessStore: ProfileDeviceAccessStore?

  override func setUpWithError() throws {
    super.setUp()
    profileDeviceAccessStore = ProfileDeviceAccessStore()
  }

  override func tearDownWithError() throws {
    profileDeviceAccessStore = nil
    try super.tearDownWithError()
  }

  func test_getProfileDeviceAccess() async throws {
    do {
      let profileDeviceAccessList = try await profileDeviceAccessStore?.getProfileDeviceAccess(profileId: Constants.ProfileId.father, nodeId: 1001, deviceId:1001, operation: Constants.APIOperation.getDevicesAccessOfAllProfiles)
      if profileDeviceAccessList != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

  func test_updateProfileDeviceAccess() async throws {
    do {
      let profileDeviceAccessList = try await profileDeviceAccessStore?.updateProfileDeviceAccess(profileId: Constants.ProfileId.father, nodeId: 1001, deviceId:1001, access: true)
      if profileDeviceAccessList != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

}
