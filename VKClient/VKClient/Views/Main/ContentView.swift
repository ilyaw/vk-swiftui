//
//  ContentView.swift
//  VKClient
//
//  Created by Ilya on 17.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    //    @ObservedObject var contentViewModel = LoginViewModel()
    
    
    @ObservedObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        //        if contentViewModel.isUserAuthorized {
        TabView(selection: $navigationViewModel.tag) {
            FriendsView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Друзья")
                }.tag(0)
            GroupsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Группы")
                }.tag(1)
            NewsfeedView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Новости")
                }.tag(2)
        }
        .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
        //            }
        //        else {
        //            VKLoginWebView()
        //                .onReceive(NotificationCenter.default.publisher(for: NSNotification.VKTokenSaved)) { _ in
        //                    contentViewModel.isUserAuthorized = true
        //                }
        //        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
