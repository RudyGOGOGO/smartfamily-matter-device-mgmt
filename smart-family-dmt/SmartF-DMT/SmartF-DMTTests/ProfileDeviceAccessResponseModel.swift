//
//  ProfileDeviceAccessResponseModel.swift
//  SmartF-DMTTests
//
//  Created by Wei Zhang on 4/26/24.
//

import XCTest
@testable import SmartF_DMT

final class ProfileDeviceAccessResponseModel: XCTestCase {
  private var profileDeviceAccessResponse: ProfileDeviceAccessResponse!
  private var profileDeviceAccessResponseBody: ProfileDeviceAccessResponseBody!
  private var profileDeviceAccess: ProfileDeviceAccess!
  
  override func setUpWithError() throws {
    super.setUp()
    profileDeviceAccess = ProfileDeviceAccess(deviceId: 1001, nodeId: 1001, access: true, location: "testLocation", profileId: Constants.ProfileId.father, profileName: "testProfileName", profileRole: Constants.ProfileRole.parent)
    profileDeviceAccessResponseBody = ProfileDeviceAccessResponseBody(profileDeviceAccessList: [profileDeviceAccess])
    profileDeviceAccessResponse = ProfileDeviceAccessResponse(statusCode: 200, body: profileDeviceAccessResponseBody)
  }
  
  override func tearDownWithError() throws {
    profileDeviceAccess = nil
    profileDeviceAccessResponseBody = nil
    profileDeviceAccessResponse = nil
    try super.tearDownWithError()
  }
  
  func testExample() throws {
    XCTAssertTrue(profileDeviceAccessResponse.statusCode == 200)
    XCTAssertTrue(profileDeviceAccessResponse.body.profileDeviceAccessList.count == 1)
    let pdaList = profileDeviceAccessResponse.body.profileDeviceAccessList[0]
    XCTAssertTrue(pdaList.deviceId == 1001)
    XCTAssertTrue(pdaList.nodeId == 1001)
    XCTAssertTrue(pdaList.access)
    XCTAssertTrue(pdaList.location == "testLocation")
    XCTAssertTrue(pdaList.profileId == Constants.ProfileId.father)
    XCTAssertTrue(pdaList.profileName == "testProfileName")
    XCTAssertTrue(pdaList.profileRole == Constants.ProfileRole.parent)
  }
}
