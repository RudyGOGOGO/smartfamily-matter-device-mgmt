//
//  Constants.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/13/24.
//

import Foundation

enum Constants {
  enum ProfileId {
    public static let father = 1001
    public static let mother = 1002
    public static let boy = 1003
    public static let girl = 1004
  }
  enum ProfileRole {
    public static let parent = "PARENT"
    public static let child = "CHILD"
  }
  enum AlertTitle {
    public static let notice = "Notice"
    public static let updateLocation = "Update Location"
    public static let updateAccess = "Update Access"
  }
  enum FontSize {
    public static let header1 = CGFloat(30)
    public static let header2 = CGFloat(25)
    public static let font1 = CGFloat(20)
    public static let font2 = CGFloat(17)
  }
  enum AvatarImage {
    public static let fatherAvatar = "FatherImage"
    public static let motherAvatar = "MotherImage"
    public static let boyAvatar = "BoyImage"
    public static let girlAvatar = "GirlImage"
    public static let defaultAvatar = "DefaultAvatar"
  }
  enum ColorAsset {
    public static let accentColor = "AccentColor"
    public static let backgroundDeepBlue = "Background-DeepBlue"
    public static let buttonColorBlue = "ButtonColor-Blue"
    public static let buttonColorYellow = "ButtonColor-Yellow"
    public static let buttonColorGreen = "ButtonColor-Green"
    public static let buttonColorLightGray = "ButtonColor-LightGray"
    public static let sectionColorBlue = "SectionColor-Blue"
    public static let sectionColorYellow = "SectionColor-Yellow"
    public static let sectionColorRed = "SectionColor-Red"
    public static let fontColorGray = "FontColor-Gray"
    public static let fontColorRed = "FontColor-Red"
  }
  enum Icon {
    public static let signOff = "person.fill.badge.minus"
    public static let disconnect = "trash.slash"
    public static let deviceTab = "house"
    public static let profileTab = "gear"
    public static let onBulb = "lightbulb.min.fill"
    public static let offBulb = "lightbulb"
    public static let onSwitch = "lightswitch.on.square.fill"
    public static let offSwitch = "lightswitch.on.square"
  }
  enum IntConstants {
    public static let msgDisplayTimeInNanoSeconds = 1500000000
  }
  enum CGFloatConstants {
    public static let buttonPadding = CGFloat(30)
    public static let cornerRadius = CGFloat(20)
    public static let sectionMaxWidth = CGFloat(326)
    public static let portraitSectionWidth = CGFloat(326)
    public static let landscapeSectionWidth = CGFloat(246)
  }
  enum DeviceStatus {
    public static let deviceStatusOn = "ON"
    public static let deviceStatusOff = "OFF"
  }
  enum URlConstant {
    public static let serverHost = "192.168.12.167"
    public static let serverPort = "8000"
    public static let matterDeviceEndpoint = "matterDevices"
    public static let discoverEndpoint = "discover"
  }
  enum APIOperation {
    public static let getDevicesAccessOfAllProfiles = "getDevicesAccessOfAllProfiles"
    public static let getDevicesAccessOfSingleProfile = "getDevicesAccessOfSingleProfile"
  }
  enum APIParameterKeys {
    public static let profileId = "profile_id"
    public static let deviceId = "device_id"
    public static let nodeId = "node_id"
    public static let operation = "operation"
    public static let devices = "devices"
    public static let location = "location"
    public static let access = "access"
  }
  enum RESTConstant {
    public static let GET = "GET"
    public static let PUT = "PUT"
    public static let DELETE = "DELETE"
    public static let POST = "POST"
  }
}
