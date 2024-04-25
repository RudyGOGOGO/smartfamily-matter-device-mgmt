//
//  GetDeviceView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/14/24.
//

import SwiftUI

struct GetDeviceView: View {
  @State var showDiscoveringMsg: Bool = false
  @State var showRetrievingMsg: Bool = false
  @State var isButtonEnabled: Bool = true
  @State var showAlert: Bool = false
  @State var alertMsg: String = ""
  @Binding var matterDeviceList: [MatterDevice]
  var profileId: Int = 0
  var profileRole: String = ""
  var mdStore = MatterDeviceStore()
  var body: some View {
    RoundedRectangle(cornerRadius: Constants.CGFloatConstants.cornerRadius)
      .fill(Color(Constants.ColorAsset.accentColor))
      .frame(maxWidth: Constants.CGFloatConstants.sectionMaxWidth, maxHeight: 176)
      .overlay(content: {
        VStack{
          Text("Get MATTER Devices")
            .foregroundStyle(.white)
            .font(.custom("Header", size: Constants.FontSize.header2))
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding([.bottom])
          HStack {
            Button {
              Task { @MainActor in
                try await getDevices(isDiscovering: true)
              }
            } label: {
              ButtonText(text: "Discover", color: Constants.ColorAsset.buttonColorGreen)
            }
            .padding([.leading, .bottom], Constants.CGFloatConstants.buttonPadding)
            .buttonStyle(PlainButtonStyle())
            .disabled(!isButtonEnabled || profileRole == Constants.ProfileRole.child)
            .onTapGesture {
              if profileRole == Constants.ProfileRole.child {
                showAlert.toggle()
                alertMsg = "No permission to discover new MATTER devices"
              }
            }
            
            Spacer()
            
            Button {
              Task { @MainActor in
                try await getDevices(isDiscovering: false)
              }
            } label: {
              ButtonText(text: "Retrieve", color: Constants.ColorAsset.buttonColorBlue)
            }
            .padding([.trailing, .bottom], Constants.CGFloatConstants.buttonPadding)
            .buttonStyle(PlainButtonStyle())
            .disabled(!isButtonEnabled)
          }
          
          if showDiscoveringMsg == true {
            ProcessMsgView(msg: "Trying to discover MATTER devices...")
          }
          
          if showRetrievingMsg == true {
            ProcessMsgView(msg: "Trying to retrieve MATTER devices...")
          }
        }.alert(isPresented: $showAlert, content: {
          Alert(
            title: Text("Notice").foregroundColor(.red),
            message: Text(alertMsg),
            dismissButton: .default(Text("OK"))
          )
        })
      })
  }
  func getDevices(isDiscovering: Bool) async throws {
    self.isButtonEnabled = false
    self.showDiscoveringMsg = isDiscovering
    self.showRetrievingMsg = !isDiscovering
    let mdList = try await isDiscovering ? mdStore.discoverNewMatterDevice(profileId: profileId) : mdStore.getMatterDevice(profileId: profileId)
    try await Task.sleep(nanoseconds: UInt64(Constants.IntConstants.msgDisplayTimeInNanoSeconds))
    self.matterDeviceList = mdList
    self.isButtonEnabled = true
    self.showDiscoveringMsg = false
    self.showRetrievingMsg = false
  }
}

#Preview {
  VStack {
    GetDeviceView(matterDeviceList: .constant([]), profileId: 1001, profileRole: "PARENT")
    GetDeviceView(matterDeviceList: .constant([]), profileId: 1001, profileRole: "CHILD")
  }
  
}

struct ProcessMsgView: View {
  var msg: String
  var body: some View {
    HStack {
      Text(msg)
        .font(.custom("msgFont", size: Constants.FontSize.font2))
        .foregroundColor(.white)
    }
  }
}
