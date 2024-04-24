//
//  MatterDeviceStore.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/13/24.
//

import Foundation

class MatterDeviceStore {
  enum MatterDeviceStoreError: Error {
    case invalidResponse
    case NotFound
  }
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration
  private let baseURL: URL
  private let getMatterDeviceOnProfileIdEndpoint: URL
  private let discoverNewMatterDeviceEndpoint: URL
  private let deleteMatterDeviceOnMatterNodeIdEndpoint: URL
  private let updateDeviceStatusEndpoint: URL
  private let updateDeviceLocationEndpoint: URL
  private let decoder = JSONDecoder()
  
  init() {
    self.sessionConfiguration = URLSessionConfiguration.default
    self.session = URLSession(configuration: sessionConfiguration)
    self.baseURL = URL(string: "http://\(Constants.URlConstant.serverHost):\(Constants.URlConstant.serverPort)")!
    self.getMatterDeviceOnProfileIdEndpoint = URL(string: Constants.URlConstant.matterDeviceEndpoint, relativeTo: baseURL)!
    self.discoverNewMatterDeviceEndpoint = URL(string: Constants.URlConstant.discoverEndpoint, relativeTo: baseURL)!
    self.deleteMatterDeviceOnMatterNodeIdEndpoint = URL(string: Constants.URlConstant.matterDeviceEndpoint, relativeTo: baseURL)!
    self.updateDeviceStatusEndpoint = URL(string: Constants.URlConstant.matterDeviceEndpoint, relativeTo: baseURL)!
    self.updateDeviceLocationEndpoint = URL(string: Constants.URlConstant.matterDeviceEndpoint, relativeTo: baseURL)!
  }
  
  func getHttpHeaderFields() -> [String: String] {
    return [
      "accept": "application/json",
      "content-type": "application/json",
      "transaction-id": UUID().uuidString
    ]
  }
  
  func getMatterDevice(profileId: Int) async throws -> [MatterDevice] {
    var searchRequest = URLRequest(url: getMatterDeviceOnProfileIdEndpoint)
    searchRequest.httpMethod = Constants.RESTConstant.GET
    searchRequest.allHTTPHeaderFields = getHttpHeaderFields()
    let queryParams = [
      URLQueryItem(name: Constants.APIParameterKeys.profileId, value: String(profileId))
    ]
    return try await getMatterDeviceHelper(searchRequest: &searchRequest, queryParams: queryParams)
  }
  
  func getMatterDevice(profileId: Int, nodeId: Int) async throws -> [MatterDevice] {
    var searchRequest = URLRequest(url: getMatterDeviceOnProfileIdEndpoint)
    searchRequest.httpMethod = Constants.RESTConstant.GET
    searchRequest.allHTTPHeaderFields = getHttpHeaderFields()
    let queryParams = [
      URLQueryItem(name: Constants.APIParameterKeys.profileId, value: String(profileId)),
      URLQueryItem(name: Constants.APIParameterKeys.nodeId, value: String(nodeId))
    ]
    return try await getMatterDeviceHelper(searchRequest: &searchRequest, queryParams: queryParams)
  }
  
  func discoverNewMatterDevice(profileId: Int) async throws -> [MatterDevice] {
    var searchRequest = URLRequest(url: discoverNewMatterDeviceEndpoint)
    searchRequest.httpMethod = Constants.RESTConstant.POST
    searchRequest.allHTTPHeaderFields = getHttpHeaderFields()
    let queryParams = [
      URLQueryItem(name: Constants.APIParameterKeys.profileId, value: String(profileId))
    ]
    return try await getMatterDeviceHelper(searchRequest: &searchRequest, queryParams: queryParams)
  }
  
  func getMatterDeviceHelper(searchRequest: inout URLRequest, queryParams: [URLQueryItem]) async throws -> [MatterDevice] {
    searchRequest.url?.append(queryItems: queryParams)
    let (mdResp, response) = try await session.data(for: searchRequest)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      return []
    }
    do {
      let matterDeviceResponse = try decoder.decode(MatterDeviceResponse.self, from: mdResp)
      return matterDeviceResponse.body.matterList
    } catch let error {
      print(error)
      return []
    }
  }
  
  func deleteMatterDeviceOnMatterNodeId(nodeId: Int) async throws -> Bool {
    var req = URLRequest(url: deleteMatterDeviceOnMatterNodeIdEndpoint)
    req.httpMethod = Constants.RESTConstant.DELETE
    req.allHTTPHeaderFields = getHttpHeaderFields()
    let queryParams = [
      URLQueryItem(name: Constants.APIParameterKeys.nodeId, value: String(nodeId))
    ]
    req.url?.append(queryItems: queryParams)
    let (_, response) = try await session.data(for: req)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      return false
    }
    return true
  }
  
  func updateDeviceStatus(profileId: Int, matterDevice: MatterDevice, status: String) async throws -> Bool {
    var req = URLRequest(url: updateDeviceStatusEndpoint)
    var device_dict_list: [[String: Any]] = []
    for device in matterDevice.devices {
      device_dict_list.append([
        Constants.APIParameterKeys.deviceId: device.deviceId,
        "status": status
      ])
    }
    let body: [String: Any] = [
      Constants.APIParameterKeys.profileId: profileId,
      Constants.APIParameterKeys.nodeId: matterDevice.nodeId,
      Constants.APIParameterKeys.operation: "updateWithSingleStatus",
      Constants.APIParameterKeys.devices: device_dict_list
    ]
    return try await updateDeviceHelper(req: &req, body: body)
  }
  
  func updateDeviceStatus(profileId: Int, nodeId: Int, deviceId: Int, status: String) async throws -> Bool {
    var req = URLRequest(url: updateDeviceStatusEndpoint)
    let body: [String: Any] = [
      Constants.APIParameterKeys.profileId: profileId,
      Constants.APIParameterKeys.nodeId: nodeId,
      Constants.APIParameterKeys.operation: "updateWithSingleStatus",
      Constants.APIParameterKeys.devices: [[
        Constants.APIParameterKeys.deviceId: deviceId,
          "status": status
        ]]
    ]
    return try await updateDeviceHelper(req: &req, body: body)
  }
  
  func updateDeviceLocation(profileId: Int, nodeId: Int, deviceId: Int, location: String) async throws -> Bool {
    var req = URLRequest(url: updateDeviceLocationEndpoint)
    let body: [String: Any] = [
      Constants.APIParameterKeys.profileId: profileId,
      Constants.APIParameterKeys.nodeId: nodeId,
      Constants.APIParameterKeys.operation: "updateWithSingleLocation",
      Constants.APIParameterKeys.devices: [[
        Constants.APIParameterKeys.deviceId: deviceId,
        Constants.APIParameterKeys.location: location
        ]]
    ]
    return try await updateDeviceHelper(req: &req, body: body)
  }
  
  func updateDeviceHelper(req: inout URLRequest, body: [String: Any]) async throws -> Bool {
    req.httpMethod = Constants.RESTConstant.PUT
    req.allHTTPHeaderFields = getHttpHeaderFields()
    if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) {
      req.httpBody = jsonData
    }
    let (_, response) = try await session.data(for: req)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      return false
    }
    return true
  }
}
