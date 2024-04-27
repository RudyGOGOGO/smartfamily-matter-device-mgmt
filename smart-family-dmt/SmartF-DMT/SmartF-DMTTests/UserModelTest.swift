//
//  UserModelTest.swift
//  SmartF-DMTTests
//
//  Created by Wei Zhang on 4/25/24.
//

import XCTest

@testable import SmartF_DMT

final class UserModelTest: XCTestCase {
  private var userResponseModel: UserResponse!
  private var profileModel: Profile!

  override func setUpWithError() throws {
    super.setUp()
    profileModel = Profile(accountId: 1001, profileId: Constants.ProfileId.father, profileName: "fatherName", profileRole: Constants.ProfileRole.parent)
    userResponseModel = UserResponse(statusCode: 200, body: profileModel)
  }

  override func tearDownWithError() throws {
    profileModel = nil
    userResponseModel = nil
    try super.tearDownWithError()
  }

  func test_userResponseModel() throws {
    XCTAssertTrue(userResponseModel.statusCode == 200)
    XCTAssertTrue(userResponseModel.body.accountId == 1001)
    XCTAssertTrue(userResponseModel.body.profileId == Constants.ProfileId.father)
    XCTAssertTrue(userResponseModel.body.profileName == "fatherName")
    XCTAssertTrue(userResponseModel.body.profileRole == Constants.ProfileRole.parent)
  }

}
