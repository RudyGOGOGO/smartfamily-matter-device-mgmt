//
//  TextView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/13/24.
//

import SwiftUI

struct TextView: View {
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct ProfileInfoText: View {
  var profileName: String
  var profileRole: String
  var profileInfoColor: Color = .white
  var body: some View {
    let profileInfoText = profileRole == "" ? "\(profileName)" : "\(profileName) | \(profileRole)"
    Text(profileInfoText)
      .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
      .foregroundStyle(.white)
      .font(.custom("ProfileInfoFont", size: Constants.FontSize.font2))
      
  }
}

struct ButtonText: View {
  var text: String
  var color: String
  var body: some View {
    Text(text)
      .font(.custom("ButtonFont", size: Constants.FontSize.font1))
      .bold()
      .padding()
      .background(Color(color))
      .foregroundColor(.white)
      .cornerRadius(Constants.TextValue.cornerRadius)
  }
}

#Preview {
  ZStack{
    Color(Constants.ColorAsset.accentColor)
    VStack {
      ButtonText(text: "Login", color: Constants.ColorAsset.buttonColorBlue)
      ProfileInfoText(profileName: "Rudy", profileRole: "PARENT")
      ProfileInfoText(profileName: "Rudy", profileRole: "")
    }
  }
}
