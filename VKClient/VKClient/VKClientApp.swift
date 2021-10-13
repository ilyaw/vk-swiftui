//
//  VKClientApp.swift
//  VKClient
//
//  Created by Ilya on 13.09.2021.
//

import SwiftUI

@main
struct VKClientApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                LoginView()
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
            }
        }
    }
}
