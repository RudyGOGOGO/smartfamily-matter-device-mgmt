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
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  func isPortrait() -> Bool {
    return horizontalSizeClass == .compact && verticalSizeClass == .regular
  }
  var matterDeviceStore = MatterDeviceStore()
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
          ).onAppear() {
            Task {@MainActor in
              self.matterDeviceList = try await matterDeviceStore.getMatterDevice(profileId: profileId)
            }
          }
          Divider().padding([.bottom], 10)
          TabView {
            NavigationStack() {
              ZStack {
                Color(Constants.ColorAsset.backgroundDeepBlue).ignoresSafeArea()
                if isPortrait() {
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
                } else {
                  HStack() {
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
            .tabItem {
              Label("Devices", systemImage: Constants.Icon.deviceTab)
            }
            .toolbar(.visible, for:.tabBar)

            ZStack {
              Color(Constants.ColorAsset.backgroundDeepBlue).ignoresSafeArea()
              VStack(alignment: .leading) {
                Text("1. Profile Name: \(profileName)")
                  .fontWeight(.bold)
                  .font(.custom("ProfileInfo-Name", size:Constants.FontSize.font1))
                  .foregroundColor(.white)
                  .padding()
                Text("2. Profile Role: \(profileRole)")
                  .fontWeight(.bold)
                  .font(.custom("ProfileInfo-Role", size:Constants.FontSize.font1))
                  .foregroundColor(.white)
                  .padding()
                Divider()
                if matterDeviceList.isEmpty {
                  Text("Note:Please retrieve connected devices at first to see all accessible items")
                    .fontWeight(.bold)
                    .font(.custom("Notice", size:Constants.FontSize.font1))
                    .foregroundColor(Color(Constants.ColorAsset.fontColorRed))
                    .padding()
                } else {
                  Text("3. List of All Accessible Devices")
                    .fontWeight(.bold)
                    .font(.custom("Device List", size:Constants.FontSize.font1))
                    .foregroundColor(.white)
                    .padding()
                  List(getAllDevicesLabel(), id: \.self) { label in
                    Text(label)
                      .fontWeight(.bold)
                      .font(.custom("Device Label", size:Constants.FontSize.font2))
                      .foregroundColor(.white)
                      .listRowBackground(Color.clear)
                  }.listStyle(PlainListStyle())
                }
                Spacer()
              }
            }
            .tabItem {
              Label("Settings", systemImage: Constants.Icon.profileTab)
            }
            .toolbar(.visible, for:.tabBar)
          }
          //change color of the bar background
          .onAppear(){
            UITabBar.appearance().backgroundColor = UIColor(Color(Constants.ColorAsset.accentColor))
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color(Constants.ColorAsset.buttonColorBlue))
          }
          .tint(.white)
        }
      }
    }
  }
  func getAllDevicesLabel() -> [String]{
    var labels: [String] = []
    for matterDevice in matterDeviceList {
      for device in matterDevice.devices {
        if device.access {
          labels.append("- \(device.deviceName) of \(matterDevice.nodeName)")
        }
      }
    }
    return labels
  }
}

#Preview {
  ContentView()
}
