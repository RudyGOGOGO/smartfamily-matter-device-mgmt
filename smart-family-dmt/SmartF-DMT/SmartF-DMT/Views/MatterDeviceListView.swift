//
//  MatterDeviceListView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/18/24.
//

import SwiftUI

struct MatterDeviceListView: View {
  var profileId: Int
  var profileRole: String
  @Binding var matterDeviceList: [MatterDevice]
  @State var showAlert: Bool = false
  @State var alertMsg: String = ""
  var matterDeviceStore = MatterDeviceStore()
  var body: some View {
    RoundedRectangle(cornerRadius: Constants.CGFloatConstants.cornerRadius)
      .fill(Color.clear)
      .frame(maxWidth: Constants.CGFloatConstants.sectionMaxWidth, maxHeight: 400)
      .overlay(content: {
        if matterDeviceList.isEmpty {
          Text("No Connected Device")
            .foregroundColor(Color(Constants.ColorAsset.fontColorGray))
            .font(.custom("msgFont", size: Constants.FontSize.header2))
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        } else {
          List(matterDeviceList, id: \.id) { matterDevice in
              NavigationLink(value: matterDevice) {
                MatterItemView(md: matterDevice, pr: profileRole, pid: profileId, mdList: $matterDeviceList)
              }
              .listRowSeparator(.hidden)
              .listRowBackground(Color.clear)
              /*
               add the following leading padding because the MatterItemView shifts to the left a little after getting wrapped in NavigationLink
               */
              .padding([.leading], 20)
          }
          .listStyle(PlainListStyle())//this PlainListStyle can make the list background transparent
          /*
           using onAppear is not efficient since after retrieving/discovering button gets triggered, it will perform the same action
           however using onAppear is easy since it can keep the matter item view always consistent with the database
           */
          .onAppear(){
            Task {@MainActor in
              self.matterDeviceList = try await matterDeviceStore.getMatterDevice(profileId: profileId)
            }
          }
        }
      }
      )
  }
}

#Preview {
  ZStack {
    Color(Constants.ColorAsset.backgroundDeepBlue)
    VStack {
      MatterDeviceListView(profileId:1001, profileRole: "PARENT", matterDeviceList: .constant([]))
      MatterDeviceListView(profileId:1001, profileRole: "PARENT", matterDeviceList: .constant([
        MatterDevice(nodeId: 1, nodeName: "Matter1001", devices: [Device(deviceId: 1, deviceName: "Bulb1", access: true, status: "ON", location: "Default"),Device(deviceId: 2, deviceName: "Bulb2", access: true, status: "OFF", location: "Default"),Device(deviceId: 3, deviceName: "Bulb2", access: true, status: "OFF", location: "Default")])
      ]))
      MatterDeviceListView(profileId:1003, profileRole: "CHILD", matterDeviceList: .constant([
        MatterDevice(nodeId: 1, nodeName: "Matter1001", devices: [Device(deviceId: 1, deviceName: "Bulb1", access: true, status: "ON", location: "Default"),Device(deviceId: 2, deviceName: "Bulb2", access: true, status: "OFF", location: "Default"),Device(deviceId: 3, deviceName: "Bulb2", access: true, status: "OFF", location: "Default")])
      ]))
    }
  }.ignoresSafeArea()
  
}
