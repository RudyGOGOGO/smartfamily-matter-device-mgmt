//
//  ProfileDeviceAccessStore.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/22/24.
//

import Foundation

class ProfileDeviceAccessStore {
  enum ProfileDeviceAccessStoreError: Error {
    case invalidResponse
    case NotFound
  }
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration
  private let baseURL: URL
  private let getProfileDeviceAccessEndpoint: URL
  private let updateProfileDeviceAccessEndpoint: URL
  private let decoder = JSONDecoder()
  
  init() {
    self.sessionConfiguration = URLSessionConfiguration.default
    self.session = URLSession(configuration: sessionConfiguration)
    self.baseURL = URL(string: "http://\(Constants.URlConstant.serverHost):\(Constants.URlConstant.serverPort)")!
    self.getProfileDeviceAccessEndpoint = URL(string: Constants.URlConstant.matterDeviceEndpoint, relativeTo: baseURL)!
    self.updateProfileDeviceAccessEndpoint = URL(string: Constants.URlConstant.matterDeviceEndpoint, relativeTo: baseURL)!
  }
  
  func getHttpHeaderFields() -> [String: String] {
    return [
      "accept": "application/json",
      "content-type": "application/json",
      "transaction-id": UUID().uuidString
    ]
  }
  
  func getProfileDeviceAccess(profileId: Int, nodeId: Int, deviceId: Int, operation: String) async throws -> [ProfileDeviceAccess] {
    var searchRequest = URLRequest(url: getProfileDeviceAccessEndpoint)
    searchRequest.httpMethod = Constants.RESTConstant.GET
    searchRequest.allHTTPHeaderFields = getHttpHeaderFields()
    let queryParams = [
      URLQueryItem(name: Constants.APIParameterKeys.profileId, value: String(profileId)),
      URLQueryItem(name: Constants.APIParameterKeys.nodeId, value: String(nodeId)),
      URLQueryItem(name: Constants.APIParameterKeys.deviceId, value: String(deviceId)),
      URLQueryItem(name: Constants.APIParameterKeys.operation, value: operation),
    ]
    searchRequest.url?.append(queryItems: queryParams)
    let (mdResp, response) = try await session.data(for: searchRequest)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      return []
    }
    do {
      let pdaResponse = try decoder.decode(ProfileDeviceAccessResponse.self, from: mdResp)
      return pdaResponse.body.profileDeviceAccessList
    } catch let error {
      //TODO: handle the error properly
      print(error)
      return []
    }
  }
  
  func updateProfileDeviceAccess(profileId: Int, nodeId: Int, deviceId: Int, access: Bool) async throws -> Bool {
    var req = URLRequest(url: updateProfileDeviceAccessEndpoint)
    let body: [String: Any] = [
      Constants.APIParameterKeys.profileId: profileId,
      Constants.APIParameterKeys.nodeId: nodeId,
      Constants.APIParameterKeys.operation: "updateWithSingleAccess",
      Constants.APIParameterKeys.devices: [[
        Constants.APIParameterKeys.deviceId: deviceId,
        Constants.APIParameterKeys.access: access
        ]]
    ]
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
