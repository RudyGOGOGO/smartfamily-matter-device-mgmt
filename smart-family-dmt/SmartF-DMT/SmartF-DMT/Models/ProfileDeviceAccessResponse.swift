//
//  ProfileDeviceAccessResponse.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/22/24.
//

import Foundation


struct ProfileDeviceAccessResponse: Codable {
  let statusCode: Int
  let body: ProfileDeviceAccessResponseBody
}

struct ProfileDeviceAccessResponseBody: Codable {
  var profileDeviceAccessList: [ProfileDeviceAccess]
  enum CodingKeys: String, CodingKey {
    case profileDeviceAccessList="pda_list"
  }
}

struct ProfileDeviceAccess: Codable {
  let id = UUID()
  let deviceId: Int
  let nodeId: Int
  let access: Bool
  let location: String
  let profileId: Int
  let profileName: String
  let profileRole: String
  enum CodingKeys: String, CodingKey {
    case deviceId="device_id",
         nodeId = "node_id",
         access,
         location,
         profileId="profile_id",
         profileName="profile_name",
         profileRole="profile_role"
  }
}
