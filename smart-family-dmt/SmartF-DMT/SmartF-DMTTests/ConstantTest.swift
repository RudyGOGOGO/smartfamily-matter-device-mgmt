//
//  ConstantTest.swift
//  SmartF-DMTTests
//
//  Created by Wei Zhang on 4/26/24.
//

import XCTest
@testable import SmartF_DMT

final class ConstantTest: XCTestCase {
    override func setUpWithError() throws {
    }
    override func tearDownWithError() throws {
    }
    func test_Constants() throws {
      XCTAssertTrue(Constants.ProfileId.father == 1001)
      XCTAssertTrue(Constants.ProfileId.mother == 1002)
      XCTAssertTrue(Constants.ProfileId.boy == 1003)
      XCTAssertTrue(Constants.ProfileId.girl == 1004)

      XCTAssertTrue(Constants.ProfileRole.child == "CHILD")
      XCTAssertTrue(Constants.ProfileRole.parent == "PARENT")

      XCTAssertTrue(Constants.AlertTitle.notice == "Notice")
      XCTAssertTrue(Constants.AlertTitle.updateLocation == "Update Location")
      XCTAssertTrue(Constants.AlertTitle.updateAccess == "Update Access")
      
      XCTAssertTrue(Constants.FontSize.header1 == CGFloat(30))
      XCTAssertTrue(Constants.FontSize.header2 == CGFloat(25))
      XCTAssertTrue(Constants.FontSize.font1 == CGFloat(20))
      XCTAssertTrue(Constants.FontSize.font2 == CGFloat(17))

      XCTAssertTrue(Constants.AvatarImage.fatherAvatar == "FatherImage")
      XCTAssertTrue(Constants.AvatarImage.motherAvatar == "MotherImage")
      XCTAssertTrue(Constants.AvatarImage.boyAvatar == "BoyImage")
      XCTAssertTrue(Constants.AvatarImage.girlAvatar == "GirlImage")
      XCTAssertTrue(Constants.AvatarImage.defaultAvatar == "DefaultAvatar")
      
      XCTAssertTrue(Constants.ColorAsset.accentColor == "AccentColor")
      XCTAssertTrue(Constants.ColorAsset.backgroundDeepBlue == "Background-DeepBlue")
      XCTAssertTrue(Constants.ColorAsset.buttonColorBlue == "ButtonColor-Blue")
      XCTAssertTrue(Constants.ColorAsset.buttonColorYellow == "ButtonColor-Yellow")
      XCTAssertTrue(Constants.ColorAsset.buttonColorGreen == "ButtonColor-Green")
      XCTAssertTrue(Constants.ColorAsset.buttonColorLightGray == "ButtonColor-LightGray")
      XCTAssertTrue(Constants.ColorAsset.sectionColorBlue == "SectionColor-Blue")
      XCTAssertTrue(Constants.ColorAsset.sectionColorYellow == "SectionColor-Yellow")
      XCTAssertTrue(Constants.ColorAsset.sectionColorRed == "SectionColor-Red")
      XCTAssertTrue(Constants.ColorAsset.fontColorGray == "FontColor-Gray")
      XCTAssertTrue(Constants.ColorAsset.fontColorRed == "FontColor-Red")


      XCTAssertTrue(Constants.Icon.signOff == "person.fill.badge.minus")
      XCTAssertTrue(Constants.Icon.disconnect == "trash.slash")
      XCTAssertTrue(Constants.Icon.deviceTab == "house")
      XCTAssertTrue(Constants.Icon.profileTab == "gear")
      XCTAssertTrue(Constants.Icon.onBulb == "lightbulb.min.fill")
      XCTAssertTrue(Constants.Icon.offBulb == "lightbulb")
      XCTAssertTrue(Constants.Icon.onSwitch == "lightswitch.on.square.fill")
      XCTAssertTrue(Constants.Icon.offSwitch == "lightswitch.on.square")

      XCTAssertTrue(Constants.IntConstants.msgDisplayTimeInNanoSeconds == 1500000000)


      XCTAssertTrue(Constants.CGFloatConstants.buttonPadding == CGFloat(30))
      XCTAssertTrue(Constants.CGFloatConstants.cornerRadius == CGFloat(20))
      XCTAssertTrue(Constants.CGFloatConstants.sectionMaxWidth == CGFloat(326))
      XCTAssertTrue(Constants.CGFloatConstants.portraitSectionWidth == CGFloat(326))
      XCTAssertTrue(Constants.CGFloatConstants.landscapeSectionWidth == CGFloat(246))

      
      XCTAssertTrue(Constants.DeviceStatus.deviceStatusOn == "ON")
      XCTAssertTrue(Constants.DeviceStatus.deviceStatusOff == "OFF")

      XCTAssertTrue(Constants.URlConstant.serverHost == "127.0.0.1")
      XCTAssertTrue(Constants.URlConstant.serverPort == "8000")
      XCTAssertTrue(Constants.URlConstant.matterDeviceEndpoint == "matterDevices")
      XCTAssertTrue(Constants.URlConstant.discoverEndpoint == "discover")


      XCTAssertTrue(Constants.APIOperation.getDevicesAccessOfAllProfiles == "getDevicesAccessOfAllProfiles")
      XCTAssertTrue(Constants.APIOperation.getDevicesAccessOfSingleProfile == "getDevicesAccessOfSingleProfile")
      
      XCTAssertTrue(Constants.APIParameterKeys.profileId == "profile_id")
      XCTAssertTrue(Constants.APIParameterKeys.deviceId == "device_id")
      XCTAssertTrue(Constants.APIParameterKeys.nodeId == "node_id")
      XCTAssertTrue(Constants.APIParameterKeys.operation == "operation")
      XCTAssertTrue(Constants.APIParameterKeys.devices == "devices")
      XCTAssertTrue(Constants.APIParameterKeys.location == "location")
      XCTAssertTrue(Constants.APIParameterKeys.access == "access")

      XCTAssertTrue(Constants.RESTConstant.GET == "GET")
      XCTAssertTrue(Constants.RESTConstant.POST == "POST")
      XCTAssertTrue(Constants.RESTConstant.PUT == "PUT")
      XCTAssertTrue(Constants.RESTConstant.DELETE == "DELETE")
    }
}
