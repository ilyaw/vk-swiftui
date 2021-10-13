//
//  FriendDetailView.swift
//  VKClient
//
//  Created by Ilya on 27.09.2021.
//

import SwiftUI

struct FriendDetailView: View {
    let friendModel: Friend
    
    var body: some View {
        VStack {
            Image(friendModel.mainPhoto)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(friendModel.fullName)
        }
    }
}

struct FriendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailView(friendModel: getFriends().first!)
    }
}
