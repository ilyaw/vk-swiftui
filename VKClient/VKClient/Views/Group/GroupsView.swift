//
//  GroupsView.swift
//  VKClient
//
//  Created by Ilya on 27.09.2021.
//

import SwiftUI

struct GroupsView: View {
    
    @ObservedObject var viewModel = GroupsViewModel(realmService: RealmService(),
                                                     networkManager: NetworkSerivce())
    
    var body: some View {
        NavigationView {
            List(viewModel.detachedGroups) { group in
                NavigationLink(destination: GroupDetailView(group: group)) {
                    StandartRowItemView(photoUrl: group.photo,
                                        text: group.name,
                                        subtext: group.activity)
                        .padding(5)
                }
            }
            .onAppear {
                viewModel.fetchGroups()
            }
            .navigationTitle("Группы")
        }.navigationViewStyle(.stack)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
