//
//  ProfileInfoView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/14/24.
//

import SwiftUI

struct ProfileInfoView: View {
  var profileId: Int
  var profileName: String
  var profileRole: String
  var body: some View {
    HStack{
      AvatarView(image: getProfileImageConstant())
      ProfileInfoText(profileName: profileName, profileRole: profileRole)
        .padding()
    }.padding([.leading])
  }
  
  //TODO: implement the image download feature
  func getProfileImageConstant() -> String {
    switch profileId {
    case Constants.ProfileId.father: return Constants.AvatarImage.fatherAvatar
    case Constants.ProfileId.mother: return Constants.AvatarImage.motherAvatar
    case Constants.ProfileId.boy: return Constants.AvatarImage.boyAvatar
    case Constants.ProfileId.girl: return Constants.AvatarImage.girlAvatar
    default: return Constants.AvatarImage.defaultAvatar
    }
  }
}

#Preview {
  ZStack{
    Color(Constants.ColorAsset.accentColor)
    VStack {
      ProfileInfoView(profileId: 1001, profileName: "Rudy", profileRole: "Parent")
      ProfileInfoView(profileId: 1001, profileName: "Rudy", profileRole: "")
    }
    
  }.ignoresSafeArea()
}
