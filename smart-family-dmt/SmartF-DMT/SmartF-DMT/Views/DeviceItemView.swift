//
//  DeviceItemView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/22/24.
//

import SwiftUI

struct DeviceItemView: View {
  //TODO: check if it is not a binding, how to keep it updated
  @State var device: Device
  var profileId: Int
  var profileRole: String
  var nodeId: Int = 0
  @State private var isOn: Bool = false
  @State private var showAlert: Bool = false
  @State private var showSheet: Bool = false
  @State private var alertType: AlertType = AlertType.notice
  @State private var alertMsg: String = ""
  @State private var alertTitle: String = ""
  @State private var updatedDeviceLocation: String = ""
  @State private var profileDeviceAccessList: [ProfileDeviceAccess] = []
  var matterDeviceStore = MatterDeviceStore()
  var profileDeviceAccessStore = ProfileDeviceAccessStore()
  init(d: Device, pr: String, pid: Int, nid: Int) {
    device = d
    profileRole = pr
    profileId = pid
    nodeId = nid
  }
  var body: some View {
    VStack{
      RoundedRectangle(cornerRadius: Constants.CGFloatConstants.cornerRadius)
        .fill(isOn ? Color(Constants.ColorAsset.sectionColorYellow) : Color(Constants.ColorAsset.accentColor))
        .frame(width: 346, height: 100)
        .overlay(content: {
          HStack {
            VStack(alignment: .leading) {
              Text(device.deviceName)
                .foregroundColor(.white)
                .font(.custom("Device Title", size: Constants.FontSize.font1))
                .padding([.top])
              Spacer()
              Text("Location: " + String(device.location))
                .foregroundColor(Color(Constants.ColorAsset.buttonColorGreen))
                .font(.custom("Update Location", size: Constants.FontSize.font2))
                .onTapGesture {
                  handleTapGestureForLocationUpdate()
                }
              Spacer()
              Text("Update Access")
                .foregroundColor(Color(Constants.ColorAsset.buttonColorGreen))
                .font(.custom("Update Access", size: Constants.FontSize.font2))
                .onTapGesture {
                  Task {@MainActor in
                    try await handleTapGestureForAccessUpdate()
                  }
                }.padding([.bottom])
            }
            
            Toggle("", isOn: $isOn)
              .onChange(of: isOn) {
                Task {@MainActor in
                  try await updateDeviceStatus()
                }
              }
              .disabled(!device.access)
              .onTapGesture {
                if !device.access {
                  updateAlertState(alertType: AlertType.notice,
                                   alertMsg: "No permission to change status of device \(device.deviceName)",
                                   alertTitle: Constants.AlertTitle.notice)
                }
              }.onAppear() {
                self.isOn = device.status == Constants.DeviceStatus.deviceStatusOn
              }
          }
          .padding([.leading, .trailing], Constants.CGFloatConstants.buttonPadding)
          .alert(
            Text(alertTitle),
            isPresented: $showAlert
          ) {
            if alertType == AlertType.updateLocation {
              UpdateLocationAlertView(updatedDeviceLocation: $updatedDeviceLocation,
                                      device: $device,
                                      profileId: profileId)
            }
          } message: {
            Text(alertMsg)
          }
          .sheet(isPresented: $showSheet, onDismiss: {
            Task {@MainActor in
              try await loadDeviceDetails()
            }
          }) {
            UpdateAccessSheetView(profileDeviceAccessList: $profileDeviceAccessList,
                                  showSheet: $showSheet,
                                  profileId: profileId,
                                  nodeId: nodeId,
                                  deviceId: device.deviceId,
                                  deviceName: device.deviceName)
            
          }
        })
    }
  }
  
  func updateAlertState(alertType: AlertType, alertMsg: String, alertTitle: String) {
    showAlert = true
    self.alertType = alertType
    self.alertMsg = alertMsg
    self.alertTitle = alertTitle
  }
  
  func updateDeviceLocation() async throws {
    let isSuccess: Bool = try await matterDeviceStore.updateDeviceLocation(profileId: profileId, nodeId: nodeId, deviceId: device.deviceId, location: updatedDeviceLocation)
    if isSuccess {
      device.location = updatedDeviceLocation
    }
  }
  
  func updateDeviceStatus() async throws {
    //    resetProperties()
    let isSuccess = try await matterDeviceStore.updateDeviceStatus(profileId: profileId, nodeId: nodeId, deviceId: device.deviceId, status: isOn ? Constants.DeviceStatus.deviceStatusOn : Constants.DeviceStatus.deviceStatusOff)
    if !isSuccess {
      updateAlertState(alertType: AlertType.notice,
                       alertMsg: isOn ? "Failed to turn on device \(device.deviceName), try again later" : "Failed to turn off device \(device.deviceName), try again later",
                       alertTitle: Constants.AlertTitle.notice)
    }
  }
  
  func handleTapGestureForLocationUpdate() {
    //    resetProperties()
    if profileRole == Constants.ProfileRole.child {
      updateAlertState(alertType: AlertType.notice,
                       alertMsg: "No permission to update the location of device \(device.deviceName)",
                       alertTitle: Constants.AlertTitle.notice)
    } else {
      updateAlertState(alertType: AlertType.updateLocation,
                       alertMsg: "",
                       alertTitle: Constants.AlertTitle.updateLocation)
    }
  }
  
  func handleTapGestureForAccessUpdate() async throws {
    //    resetProperties()
    if profileRole == Constants.ProfileRole.child {
      updateAlertState(alertType: AlertType.notice,
                       alertMsg: "No permission to update the access of device \(device.deviceName)",
                       alertTitle: Constants.AlertTitle.notice)
    } else {
      let pdaList = try await profileDeviceAccessStore.getProfileDeviceAccess(profileId: profileId, nodeId: nodeId, deviceId: device.deviceId, operation: Constants.APIOperation.getDevicesAccessOfAllProfiles)
      if pdaList.isEmpty {
        updateAlertState(alertType: AlertType.notice,
                         alertMsg: "Failed to get the family members' access list for device \(device.deviceName), try again later!",
                         alertTitle: Constants.AlertTitle.notice)
      } else {
        self.profileDeviceAccessList = pdaList
        self.showSheet = true
      }
    }
  }
  
  func loadDeviceDetails() async throws {
    let accessList = try await profileDeviceAccessStore.getProfileDeviceAccess(profileId: profileId, nodeId: nodeId, deviceId: device.deviceId, operation: Constants.APIOperation.getDevicesAccessOfSingleProfile)
    if accessList.isEmpty {
      updateAlertState(alertType: AlertType.notice,
                       alertMsg: "Failed to fetch the latest access status, go to main page and try it again",
                       alertTitle: Constants.AlertTitle.notice)
    } else {
      self.device.access = accessList[0].access
      self.device.location = accessList[0].location
    }
  }
  
  func resetProperties() {
    self.alertType = AlertType.notice
    self.alertMsg = ""
    self.alertTitle = ""
    self.updatedDeviceLocation = ""
    self.profileDeviceAccessList = []
  }
}

struct UpdateAccessSheetView: View {
  @Binding var profileDeviceAccessList: [ProfileDeviceAccess]
  @Binding var showSheet: Bool
  var profileId: Int
  var nodeId: Int
  var deviceId: Int
  var deviceName: String
  //TODO: we should use the singleton
  var profileDeviceAccessStore = ProfileDeviceAccessStore()
  var body: some View {
    ZStack {
      Color(Constants.ColorAsset.accentColor)
      VStack {
        Text("Update Family Members' Access")
          .font(.custom("UpdateAccessFont", size: Constants.FontSize.font1))
          .foregroundColor(.white)
          .padding([.top], 30)
        Spacer()
        List(profileDeviceAccessList, id: \.id) { profileDeviceAccess in
          ProfileAccessView(pid: profileDeviceAccess.profileId,
                            pName: profileDeviceAccess.profileName,
                            did: profileDeviceAccess.deviceId, 
                            dName: deviceName, nid: nodeId,
                            access: profileDeviceAccess.access)
            .listRowBackground(Color.clear)
        }.listStyle(PlainListStyle())//this PlainListStyle can make the list background
      }
    }
  }
}

struct UpdateLocationAlertView: View {
  @Binding var updatedDeviceLocation: String
  @Binding var device: Device
  var profileId: Int
  var nodeId: Int = 0
  //TODO: we should use the singleton
  var matterDeviceStore = MatterDeviceStore()
  var body: some View {
    VStack {
      Button("Cancel", role: .cancel) {}
      Button(action: {
        Task { @MainActor in
          try await updateDeviceLocation()
        }
      }) {
        Text("OK").foregroundColor(Color.blue)
      }
      .disabled(updatedDeviceLocation.isEmpty)
      TextField("Location Name", text: $updatedDeviceLocation).textContentType(.nickname)
    }
  }
  func updateDeviceLocation() async throws {
    let isSuccess: Bool = try await matterDeviceStore.updateDeviceLocation(profileId: profileId, nodeId: nodeId, deviceId: device.deviceId, location: updatedDeviceLocation)
    if isSuccess {
      device.location = updatedDeviceLocation
    }
  }
}

#Preview {
  VStack {
    DeviceItemView(d: Device(deviceId: 1001, deviceName: "Bulb1", access: true, status: "ON", location: "Default"), pr: Constants.ProfileRole.parent, pid: 1001, nid:1001)
    DeviceItemView(d: Device(deviceId: 1002, deviceName: "Bulb2", access: false, status: "ON", location: "Default"), pr: Constants.ProfileRole.child, pid: 1003, nid:1001)
    
  }
}