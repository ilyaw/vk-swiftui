//
//  FriendsView.swift
//  VKClient
//
//  Created by Ilya on 21.09.2021.
//

import SwiftUI

struct FriendsView: View {
        
    @ObservedObject var viewModel = FriendsViewModel(realmService: RealmService(),
                                                     networkManager: NetworkSerivce())
    
    var body: some View {
        NavigationView {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            } else {
            List(viewModel.detachedFriends) { friend in
                NavigationLink(destination: FriendPhotosView(friend: friend)) {
                    StandartRowItemView(photoUrl: friend.photo, text: friend.fullName)
                        .padding(5)
                }
            }
            .onAppear {
                viewModel.fetchFriends()
            }
            .navigationTitle("Друзья")
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
