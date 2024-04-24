//
//  UserStore.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/10/24.
//

import Foundation

class UserStore {
  enum UserStoreError: Error {
    case invalidResponse
    case NotFound
  }
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration
  private let baseURL: URL
  private let profileEndpoint: URL
  private let decoder = JSONDecoder()
  
  init() {
    self.sessionConfiguration = URLSessionConfiguration.default
    self.session = URLSession(configuration: sessionConfiguration)
    self.baseURL = URL(string: "http://\(Constants.URlConstant.serverHost):\(Constants.URlConstant.serverPort)")!
    self.profileEndpoint = URL(string: "profile", relativeTo: baseURL)!
  }
  
  func getProfile(userName: String, pwd: String) async throws -> Profile? {
    var searchRequest = URLRequest(url: profileEndpoint)
    searchRequest.httpMethod = "GET"
    searchRequest.allHTTPHeaderFields = [
      "accept": "application/json",
      "content-type": "application/json",
      "transaction-id": UUID().uuidString
    ]
    let queryParams = [
      URLQueryItem(name: "user_name", value: userName),
      URLQueryItem(name: "password", value: pwd),
    ]
    searchRequest.url?.append(queryItems: queryParams)
    let (userResp, response) = try await session.data(for: searchRequest)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      return nil
    }
    do {
      let userResponse = try decoder.decode(UserResponse.self, from: userResp)
      return userResponse.body
    } catch let error {
      print(error)
      return nil
    }
  }
}
