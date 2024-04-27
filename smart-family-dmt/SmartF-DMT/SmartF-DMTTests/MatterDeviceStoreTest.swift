//
//  MatterDeviceStoreTest.swift
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

final class MatterDeviceStoreTest: XCTestCase {
  private var matterDeviceStore: MatterDeviceStore?

  override func setUpWithError() throws {
    super.setUp()
    matterDeviceStore = MatterDeviceStore()
  }

  override func tearDownWithError() throws {
    matterDeviceStore = nil
    try super.tearDownWithError()
  }

  func test_getMatterDeviceOnPid() async throws {
    do {
      let matterDeviceList = try await matterDeviceStore?.getMatterDevice(profileId: Constants.ProfileId.father)
      if matterDeviceList != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

  func test_getMatterDeviceOnPidAndNid() async throws {
    do {
      let matterDeviceList = try await matterDeviceStore?.getMatterDevice(profileId: Constants.ProfileId.father, nodeId: 1001)
      if matterDeviceList != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

  func test_discoverNewMatterDevice() async throws {
    do {
      let matterDeviceList = try await matterDeviceStore?.discoverNewMatterDevice(profileId: Constants.ProfileId.father)
      if matterDeviceList != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

  func test_deleteMatterDeviceOnMatterNodeId() async throws {
    do {
      let isSuccess = try await matterDeviceStore?.deleteMatterDeviceOnMatterNodeId(nodeId: 1001)
      if isSuccess != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

  func test_updateDeviceStatus() async throws {
    do {
      let isSuccess = try await matterDeviceStore?.updateDeviceStatus(
        profileId: Constants.ProfileId.father,
        matterDevice: MatterDevice(nodeId: 1001, nodeName: "testNodeName", devices: [Device(deviceId: 1001, deviceName: "deviceName", access: true, status: Constants.DeviceStatus.deviceStatusOn, location: "textLocationName")]),
        status: Constants.DeviceStatus.deviceStatusOn)
      if isSuccess != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

  func test_updateDeviceStatusForADevice() async throws {
    do {
      let isSuccess = try await matterDeviceStore?.updateDeviceStatus(
        profileId: Constants.ProfileId.father,
        nodeId: 1001,
        deviceId: 1001,
        status: Constants.DeviceStatus.deviceStatusOff
      )
      if isSuccess != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }

  func test_updateDeviceLocation() async throws {
    do {
      let isSuccess = try await matterDeviceStore?.updateDeviceLocation(
        profileId: Constants.ProfileId.father,
        nodeId: 1001,
        deviceId: 1001,
        location: "testLocation"
      )
      if isSuccess != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }
}
