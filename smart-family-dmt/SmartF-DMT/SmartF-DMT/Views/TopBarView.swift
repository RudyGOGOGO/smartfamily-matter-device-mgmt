//
//  TopBarView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/13/24.
//

import SwiftUI

struct TopBarView: View {
  @Binding var isAuthorized: Bool
  @Binding var accountId: Int
  @Binding var profileId: Int
  @Binding var profileName: String
  @Binding var profileRole: String
  @Binding var matterDeviceList: [MatterDevice]
  var body: some View {
    HStack(alignment: .center) {
      ProfileInfoView(profileId: profileId, profileName: profileName, profileRole: profileRole)
      Spacer()
      Button {
        isAuthorized.toggle()
        self.accountId = 0
        self.profileId = 0
        self.profileName = ""
        self.profileRole = ""
        self.matterDeviceList = []
      } label: {
        Image(systemName: Constants.Icon.signOff)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 43, height: 48)
          .foregroundColor(.white)
          .padding([.trailing])
      }
    }
  }
}

#Preview {
  ZStack{
    Color(Constants.ColorAsset.accentColor)
    TopBarView(isAuthorized: .constant(true), 
               accountId: .constant(1001),
               profileId: .constant(Constants.ProfileId.father),
               profileName: .constant("Rudy"),
               profileRole: .constant(Constants.ProfileRole.parent),
               matterDeviceList: .constant([])
    )
  }.ignoresSafeArea()
}
