//
//  Login.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/12/24.
//

import SwiftUI

struct Login: View {
  @State private var userName = ""
  @State private var password = ""
  @State private var showAlert = false
  @State private var alertMsg = ""
  @Binding var accountId: Int
  @Binding var profileId: Int
  @Binding var profileName: String
  @Binding var profileRole: String
  @Binding var isAuthorized: Bool
  @ObservedObject var userStore: UserStore
  private let loginTitle = "SmartFamily-DMT"
  private let loginIdField = "Username"
  private let loginKeyField = "Password"
  var body: some View {
    VStack {
      Text(loginTitle)
        .foregroundStyle(.white)
        .font(.custom("header1", size: Constants.FontSize.header1))
        .padding()
      
      TextField(loginIdField, text: $userName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      
      SecureField(loginKeyField, text: $password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      
      Button {
        if self.userName == "" {
          self.showAlert = true
          self.alertMsg = "username is missing"
        } else if self.password == "" {
          self.showAlert = true
          self.alertMsg = "password is missing"
        }
        Task{ @MainActor in
          await userStore.getProfile(userName: self.userName, pwd: self.password)
          print(userStore.profile == nil ? "1234" : "2345")
          if userStore.profile == nil {
            self.showAlert = true
            self.alertMsg = "Wrong username or password"
            self.password = ""
          } else {
            self.isAuthorized = true
            self.accountId = userStore.profile!.accountId
            self.profileId = userStore.profile!.profileId
            self.profileName = userStore.profile!.profileName
            self.profileRole = userStore.profile!.profileRole
          }
        }
      } label: {
        ButtonText(text: "Login", color: Constants.ColorAsset.buttonColorBlue)
      }
      .alert(self.alertMsg, isPresented: $showAlert){
        Button("Retry", role: .cancel) {}
      }
    }
    .padding()
  }
}

#Preview {
  ZStack{
    Color(Constants.ColorAsset.accentColor)
    Login(accountId: .constant(0),
          profileId: .constant(0),
          profileName: .constant(""),
          profileRole: .constant(""),
          isAuthorized: .constant(false),
          userStore:UserStore())
  }.ignoresSafeArea()
}
