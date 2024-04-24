//
//  AvatarView.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/13/24.
//

import SwiftUI

struct AvatarView: View {
  var image: String
  var body: some View {
    Image(image)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 70, height: 70)
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.white, lineWidth: 1))
  }
}

#Preview {
  VStack {
    AvatarView(image: Constants.AvatarImage.fatherAvatar)
    AvatarView(image: Constants.AvatarImage.motherAvatar)
    AvatarView(image: Constants.AvatarImage.boyAvatar)
    AvatarView(image: Constants.AvatarImage.girlAvatar)
  }
}
