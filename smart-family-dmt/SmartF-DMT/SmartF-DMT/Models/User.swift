//
//  User.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/10/24.
//

import Foundation

struct UserResponse: Codable {
  let statusCode: Int
  let body: Profile
}

struct Profile: Codable {
  let id = UUID()
  let accountId: Int
  let profileId: Int
  let profileName: String
  let profileRole: String
  enum CodingKeys: String, CodingKey {
    case accountId="account_id",
         profileId="profile_id",
         profileName="profile_name",
         profileRole="profile_role"
  }
}

