//
//  Enums.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/22/24.
//

import Foundation

enum AlertType {
  case notice, updateLocation, updateAccess
}

enum ServiceError: Error {
  case initializationError
}
