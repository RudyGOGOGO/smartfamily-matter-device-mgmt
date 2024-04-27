//
//  DeviceDetailsView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/23/24.
//

import SwiftUI


struct DeviceDetailsView: View {
  @State var matterDevice: MatterDevice
  var profileId: Int
  var profileRole: String
  var nodeId: Int
  /*
   Note: use @ObservedObject matterDeviceStore to reuse the same MatterDeviceStore object
   */
  var matterDeviceStore: MatterDeviceStore = MatterDeviceStore()
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  func isPortrait() -> Bool {
    return horizontalSizeClass == .compact && verticalSizeClass == .regular
  }
  init(profileId: Int, profileRole: String, nodeId: Int) {
    self.profileId = profileId
    self.profileRole = profileRole
    self.nodeId = nodeId
    self.matterDevice = MatterDevice(nodeId: nodeId, nodeName: "", devices: [])
  }
  var body: some View {
    ZStack {
      Color(Constants.ColorAsset.backgroundDeepBlue)
      RoundedRectangle(cornerRadius: Constants.CGFloatConstants.cornerRadius)
        .fill(Color.clear)
        .frame(maxWidth: 346, maxHeight: 400)
        .overlay(content: {
          if matterDevice.devices.isEmpty {
            Text("No Connected Device")
              .foregroundColor(Color(Constants.ColorAsset.fontColorGray))
              .font(.custom("msgFont", size: Constants.FontSize.header2))
              .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          } else {
            if isPortrait() {
              List(matterDevice.devices, id: \.id) { device in
                DeviceItemView(d: device, pr: profileRole, pid: profileId, nid: matterDevice.nodeId)
                //set the list row background as transparent
                  .listRowBackground(Color.clear)
              }
              .listStyle(PlainListStyle())//this PlainListStyle can make the list background transparent
            } else {
              ScrollView {
                LazyVGrid(columns: [GridItem(.fixed(Constants.CGFloatConstants.landscapeSectionWidth)), GridItem(.fixed(Constants.CGFloatConstants.landscapeSectionWidth))]) {
                  ForEach(matterDevice.devices, id: \.id) { device in
                    DeviceItemView(d: device, pr: profileRole, pid: profileId, nid: matterDevice.nodeId)
                  }
                }
              }
            }

          }
        }
        )
    }
    .onAppear() {
      Task {@MainActor in
        do {
          let matterDeviceList = try await matterDeviceStore.getMatterDevice(profileId: profileId, nodeId: nodeId)
          if matterDeviceList.isEmpty{
            throw ServiceError.initializationError
          }
          self.matterDevice = matterDeviceList[0]
        } catch let error {
          //TODO: handle the error properly
          print(error)
        }
      }
    }
    .ignoresSafeArea()

  }
}

#Preview {
  DeviceDetailsView(profileId: 1001, profileRole: Constants.ProfileRole.parent, nodeId: 1001)
}
