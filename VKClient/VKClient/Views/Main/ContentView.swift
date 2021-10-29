//
//  ContentView.swift
//  VKClient
//
//  Created by Ilya on 17.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var contentViewModel = ContentViewModel()
    
    var body: some View {
        if contentViewModel.isUserAuthorized {
            TabView {
                FriendsView()
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Друзья")
                    }
                GroupsView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Группы")
                    }
                NewsfeedView()
                    .tabItem {
                        Image(systemName: "newspaper.fill")
                        Text("Новости")
                    }
            }
            .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
        } else {
            VKLoginWebView()
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.VKTokenSaved)) { _ in
                    contentViewModel.isUserAuthorized = true
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
