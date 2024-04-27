//
//  MatterDeviceResponseModel.swift
//  SmartF-DMTTests
//
//  Created by Wei Zhang on 4/26/24.
//

import XCTest
@testable import SmartF_DMT

final class MatterDeviceResponseModelTest: XCTestCase {
  private var matterDeviceResponse: MatterDeviceResponse!
  private var matterDeviceResponseBody: MatterDeviceResponseBody!
  private var matterDevice: MatterDevice!
  private var device: Device!

  override func setUpWithError() throws {
    super.setUp()
    device = Device(deviceId: 1001, deviceName: "testDeviceName", access: true, status: Constants.DeviceStatus.deviceStatusOn, location: "testLocation")
    matterDevice = MatterDevice(nodeId: 1001, nodeName: "testNodeName", devices: [device])
    matterDeviceResponseBody = MatterDeviceResponseBody(matterList: [matterDevice])
    matterDeviceResponse = MatterDeviceResponse(statusCode: 200, body: matterDeviceResponseBody)
  }
  
  override func tearDownWithError() throws {
    device = nil
    matterDevice = nil
    matterDeviceResponseBody = nil
    matterDeviceResponse = nil
    try super.tearDownWithError()
  }
  
  func test_MatterDeviceResponse() throws {
    XCTAssertTrue(matterDeviceResponse.statusCode == 200)
    XCTAssertTrue(matterDeviceResponse.body.matterList.count == 1)
    let md = matterDeviceResponse.body.matterList[0]
    XCTAssertTrue(md.nodeId == 1001)
    XCTAssertTrue(md.nodeName == "testNodeName")
    XCTAssertTrue(md.devices.count == 1)
    let d = md.devices[0]
    XCTAssertTrue(d.deviceId == 1001)
    XCTAssertTrue(d.deviceName == "testDeviceName")
    XCTAssertTrue(d.access)
    XCTAssertTrue(d.status == Constants.DeviceStatus.deviceStatusOn)
    XCTAssertTrue(d.location == "testLocation")
  }

  func test_updateDevices() throws {
    matterDevice.updateDevices(dList: [Device(deviceId: 1002, deviceName: "testDeviceName2", access: true, status: Constants.DeviceStatus.deviceStatusOff, location: "testLocation2")])
    let d = matterDevice.devices[0]
    XCTAssertTrue(d.deviceId == 1002)
    XCTAssertTrue(d.deviceName == "testDeviceName2")
    XCTAssertTrue(d.access)
    XCTAssertTrue(d.status == Constants.DeviceStatus.deviceStatusOff)
    XCTAssertTrue(d.location == "testLocation2")

  }
}
