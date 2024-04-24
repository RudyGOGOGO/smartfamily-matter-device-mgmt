//
//  MatterDeviceResponse.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/12/24.
//

import Foundation

struct MatterDeviceResponse: Codable {
  let statusCode: Int
  let body: MatterDeviceResponseBody
}

struct MatterDeviceResponseBody: Codable {
  var matterList: [MatterDevice]
  enum CodingKeys: String, CodingKey {
    case matterList="matter_list"
  }
}

struct MatterDevice: Codable, Hashable {
  let id = UUID()
  let nodeId: Int
  let nodeName: String
  var devices: [Device]
  enum CodingKeys: String, CodingKey {
    case nodeId="node_id",
         nodeName = "node_name",
         devices
  }
  mutating func updateDevices(dList: [Device]) {
    self.devices = dList
  }
}

struct Device: Codable, Hashable {
  let id = UUID()
  let deviceId: Int
  let deviceName: String
  var access: Bool
  var status: String
  var location: String
  enum CodingKeys: String, CodingKey {
    case deviceId="device_id",
         deviceName="device_name",
         access,
         status,
         location
  }
}

