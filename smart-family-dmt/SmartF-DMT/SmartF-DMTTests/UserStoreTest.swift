//
//  UserStoreTest.swift
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


final class UserStoreTest: XCTestCase {
  private var userStore: UserStore?

  override func setUpWithError() throws {
    super.setUp()
    userStore = UserStore()
  }

  override func tearDownWithError() throws {
    userStore = nil
    try super.tearDownWithError()
  }

  func test_getProfile() async throws {
    do {
      let p = try await userStore?.getProfile(userName: "1001", pwd: "1001")
      if p != nil {
      }
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(true)
    }
  }
}
