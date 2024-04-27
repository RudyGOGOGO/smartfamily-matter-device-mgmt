//
//  UserStore.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/10/24.
//

import Foundation

class UserStore: ObservableObject {
  enum UserStoreError: Error {
    case invalidResponse
    case NotFound
  }
  var session: URLSession
  var sessionConfiguration: URLSessionConfiguration
  var baseURL: URL
  var profileEndpoint: URL
  @Published var profile: Profile?
  private let decoder = JSONDecoder()
  
  init() {
    self.sessionConfiguration = URLSessionConfiguration.default
    self.session = URLSession(configuration: sessionConfiguration)
    self.baseURL = URL(string: "http://\(Constants.URlConstant.serverHost):\(Constants.URlConstant.serverPort)")!
    self.profileEndpoint = URL(string: "profile", relativeTo: baseURL)!
  }
  
  func getProfile(userName: String, pwd: String) async {
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
    do {
      let (userResp, response) = try await session.data(for: searchRequest)
      guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
      else {
        await updateProfile(nil)
        return
  //      throw UserStoreError.NotFound
      }
      let userResponse = try decoder.decode(UserResponse.self, from: userResp)
      await updateProfile(userResponse.body)
    } catch {
      await updateProfile(nil)
//      throw UserStoreError.invalidResponse
    }
  }

  func updateProfile(_ p: Profile?) async {
    await MainActor.run {
      print("1234")
      self.profile = p
    }
  }
}
