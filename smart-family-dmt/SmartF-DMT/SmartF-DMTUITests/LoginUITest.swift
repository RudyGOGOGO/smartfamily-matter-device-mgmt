//
//  LoginUITest.swift
//  SmartF-DMTUITests
//
//  Created by Wei Zhang on 4/26/24.
//

import XCTest

final class LoginUITest: XCTestCase {
  private var app: XCUIApplication!


  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchArguments=["-ui-testing"]
    app.launchEnvironment=["-networking-success":"1"]
    app.launch()
  }

  override func tearDownWithError() throws {
    app = nil
  }

  func test_loginUIComponents() throws {
    let app = XCUIApplication()
    app.launch()
    let usernameField = app.textFields["Username"]
    XCTAssertTrue(usernameField.exists)
    usernameField.tap()
    usernameField.typeText("1001")
    let passwordField = app.secureTextFields["Password"]
    XCTAssertTrue(passwordField.exists)
    passwordField.tap()
    passwordField.typeText("1001")
    let loginButton = app.buttons["Login"]
    XCTAssertTrue(loginButton.exists)
    loginButton.tap()
  }
}
