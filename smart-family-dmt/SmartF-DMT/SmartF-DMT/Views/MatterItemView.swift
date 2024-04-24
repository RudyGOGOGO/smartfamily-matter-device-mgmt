//
//  MatterItemView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/18/24.
//

import SwiftUI

struct MatterItemView: View {
  //TODO: check if it is not a binding, how to keep it updated
  var matterDevice: MatterDevice
  var profileId: Int
  var profileRole: String
  @State private var isOn: Bool
  @State private var numOfOnDevice: Int
  @State private var showAlert: Bool = false
  @State private var alertMsg: String = ""
  @Binding var matterDeviceList: [MatterDevice]
  var matterDeviceStore = MatterDeviceStore()
  init(md: MatterDevice, pr: String, pid: Int, mdList: Binding<[MatterDevice]>) {
    matterDevice = md
    profileRole = pr
    profileId = pid
    var count = 0
    for (_, device) in md.devices.enumerated() {
      if device.status == Constants.DeviceStatus.deviceStatusOn {
        count += 1
      }
    }
    isOn = count > 0
    numOfOnDevice = count
    _matterDeviceList = mdList//assign the binding value to the property through the init method
  }
  var body: some View {
    VStack{
      RoundedRectangle(cornerRadius: Constants.CGFloatConstants.cornerRadius)
        .fill(isOn ? Color(Constants.ColorAsset.sectionColorYellow) : Color(Constants.ColorAsset.accentColor))
        .frame(width: Constants.CGFloatConstants.sectionMaxWidth, height: 100)
        .overlay(content: {
          HStack {
            VStack(alignment: .leading) {
              Text(matterDevice.nodeName)
                .foregroundColor(.white)
                .font(.custom("Matter Title", size: Constants.FontSize.font1))
              Text("Total Devices: " + String(matterDevice.devices.count))
                .foregroundColor(isOn ? Color(Constants.ColorAsset.fontColorRed) : Color(Constants.ColorAsset.fontColorGray))
                .font(.custom("Matter Devices Summary", size: Constants.FontSize.font2))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
              Text("ON Devices: " + String(numOfOnDevice))
                .foregroundColor(isOn ? Color(Constants.ColorAsset.fontColorRed) : Color(Constants.ColorAsset.fontColorGray))
                .font(.custom("Matter Devices Status Count", size: Constants.FontSize.font2))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            Toggle("", isOn: $isOn)
              .onChange(of: isOn) {
                Task {
                  let isSuccess = try await matterDeviceStore.updateDeviceStatus(profileId: profileId, matterDevice: matterDevice, status: isOn ? Constants.DeviceStatus.deviceStatusOn : Constants.DeviceStatus.deviceStatusOff)
                  showAlert = true
                  if isSuccess {
                    numOfOnDevice = isOn ? matterDevice.devices.count : 0
                    alertMsg = isOn ? "Successfully turned on all devices of \(matterDevice.nodeName)" : "Successfully turned off all devices of \(matterDevice.nodeName)"
                  } else {
                    alertMsg = isOn ? "Failed to turn on all devices of \(matterDevice.nodeName), try again later" : "Failed to turn off all devices of \(matterDevice.nodeName), try again later"
                  }
                }
              }
              .disabled(Constants.ProfileRole.child == profileRole)
              .onTapGesture {
                showAlert = true
                if profileRole == Constants.ProfileRole.child {
                  alertMsg = "No permission to change status for all devices of \(matterDevice.nodeName)"
                }
              }
          }
          .padding([.leading, .trailing], Constants.CGFloatConstants.buttonPadding)
          .alert(isPresented: $showAlert, content: {
            Alert(
              title: Text("Notice").foregroundColor(.red),
              message: Text(alertMsg),
              dismissButton: .default(Text("OK"))
            )
          })
        })
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
          Button {
            Task { @MainActor in
              try await performUnpaired(matterDevice: matterDevice)
            }
          } label: {
            Label("Disconnect", systemImage: Constants.Icon.disconnect)
              .cornerRadius(Constants.CGFloatConstants.cornerRadius)
          }
          .tint(Color(Constants.ColorAsset.sectionColorRed))
        }
    }
  }
  func performUnpaired(matterDevice: MatterDevice) async throws {
    if profileRole == Constants.ProfileRole.child {
      self.showAlert = true
      self.alertMsg = "No permission to perform this action"
      return
    }
    let isSuccess: Bool = try await matterDeviceStore.deleteMatterDeviceOnMatterNodeId(nodeId: matterDevice.nodeId)
    self.showAlert = true
    self.alertMsg = isSuccess ? "Successfully disconnected the MATTER device \(matterDevice.nodeName)" : "Failed to disconnect the MATTER device \(matterDevice.nodeName)"
    if isSuccess {
      let ls = try await matterDeviceStore.getMatterDevice(profileId: profileId)
      //TODO: check why the matter device list does not get updated
      self.matterDeviceList = ls
    }
  }
  
}

#Preview {
  VStack {
    MatterItemView(md: MatterDevice(nodeId: 1, nodeName: "Matter1001", devices: [Device(deviceId: 1, deviceName: "Bulb1", access: true, status: "ON", location: "Default"),
        Device(deviceId: 2, deviceName: "Bulb2", access: true, status: "OFF", location: "Default"),
        Device(deviceId: 2, deviceName: "Bulb2", access: true, status: "OFF", location: "Default")]),
                   pr: Constants.ProfileRole.parent, pid: 1001, mdList: .constant([]))
    MatterItemView(md: MatterDevice(nodeId: 1, nodeName: "Matter1001", devices: [Device(deviceId: 1, deviceName: "Bulb1", access: true, status: "ON", location: "Default"),
        Device(deviceId: 2, deviceName: "Bulb2", access: true, status: "OFF", location: "Default"),
        Device(deviceId: 2, deviceName: "Bulb2", access: true, status: "OFF", location: "Default")]),
                   pr: Constants.ProfileRole.child, pid: 1003, mdList: .constant([]))
    
  }
  
}
