//
//  ProfileAccessView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/23/24.
//

import SwiftUI

struct ProfileAccessView: View {
  @State private var isOn: Bool
  @State private var showAlert: Bool = false
  @State private var alertMsg: String = ""
  var profileId: Int
  var profileName: String
  var deviceId: Int
  var deviceName: String
  var nodeId: Int
  /*
   Note: use @ObservedObject profileDeviceAccessStore to reuse the same ProfileDeviceAccessStore object
   */
  var profileDeviceAccessStore = ProfileDeviceAccessStore()
  init(pid: Int, pName: String, did: Int, dName: String, nid: Int, access: Bool) {
    self.profileId = pid
    self.profileName = pName
    self.deviceId = did
    self.deviceName = dName
    self.nodeId = nid
    self.isOn = access
  }
  var body: some View {
    HStack {
      ProfileInfoView(profileId: profileId, profileName: profileName, profileRole: "")
      Toggle("", isOn: $isOn)
        .onChange(of: isOn) {
          Task {@MainActor in
            let isSuccess = try await profileDeviceAccessStore
              .updateProfileDeviceAccess(profileId: profileId,
                                         nodeId: nodeId,
                                         deviceId: deviceId,
                                         access: isOn)
            showAlert = true
            if isSuccess {
              alertMsg = "Successfully updated access for \(profileName) to device \(deviceName)"
            } else {
              alertMsg = "Failed to update access for \(profileName) to device \(deviceName), try again later"
            }
          }
        }.tint(.green)
    }.alert(
      Text(Constants.AlertTitle.notice),
      isPresented: $showAlert
    ) {
    } message: {
      Text(alertMsg)
    }
  }
}

#Preview {
  ZStack{
    Color(Constants.ColorAsset.accentColor)
    ProfileAccessView(pid: 1001, pName: "Rudy", did: 1001, dName: "Bulb1", nid: 1001, access: true)
  }.ignoresSafeArea()
  
}
