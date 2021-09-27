//
//  FriendsView.swift
//  VKClient
//
//  Created by Ilya on 21.09.2021.
//

import SwiftUI

struct FriendsView: View {
    
    private var friends = getFriends()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(friends) { friend in
                    NavigationLink(destination: FriendDetailView(friendModel: friend)) {
                        
                        RowItemView(photo: Image(friend.mainPhoto),
                                    text: friend.fullName)

                    }
                }
                
            }
            .navigationTitle("Друзья")
        }.navigationViewStyle(.stack)
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
