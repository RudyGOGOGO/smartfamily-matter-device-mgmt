//
//  ContentView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/10/24.
//

import SwiftUI

struct ContentView: View {
  @State private var isAuthorized = false
  @State private var accountId: Int = 0
  @State private var profileId: Int = 0
  @State private var profileName: String = ""
  @State private var profileRole: String = ""
  @State var matterDeviceList: [MatterDevice] = []
  var body: some View {
    ZStack {
      Color(Constants.ColorAsset.accentColor).ignoresSafeArea()
      VStack{
        if isAuthorized == false {
          Login(accountId: $accountId,
                profileId: $profileId,
                profileName: $profileName,
                profileRole: $profileRole,
                isAuthorized: $isAuthorized)
        } else {
          TopBarView(isAuthorized: $isAuthorized,
                     accountId: $accountId,
                     profileId: $profileId,
                     profileName: $profileName,
                     profileRole: $profileRole,
                     matterDeviceList: $matterDeviceList
          )
          Divider().padding([.bottom], 10)
          NavigationStack() {
            ZStack {
              Color(Constants.ColorAsset.backgroundDeepBlue)
              VStack() {
                GetDeviceView(matterDeviceList: $matterDeviceList, profileId: profileId, profileRole: profileRole)
                  .frame(maxHeight: 190)
                Divider().padding([.top], 20)
                MatterDeviceListView(profileId: profileId, profileRole: profileRole, matterDeviceList: $matterDeviceList)
                  .navigationDestination(for: MatterDevice.self) { matterDevice in
                    //Note: apply the navigationBarBackButtonHidden to the destination view
                    DeviceDetailsView(profileId: profileId, profileRole: profileRole, nodeId: matterDevice.nodeId)
                  }
              }
            }
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
