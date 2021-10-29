//
//  GroupsView.swift
//  VKClient
//
//  Created by Ilya on 27.09.2021.
//

import SwiftUI

struct GroupsView: View {
    
    private var groups = getGroups()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groups) { group in
//                    NavigationLink(destination: GroupDetailView(group: group)) {
//                        StandartRowItemView(photo: Image(group.postOwnerImage),
//                                            text: group.groupName,
//                                            subtext: group.shortInfo)
//                            .padding(5)
//                    }
                }
            }.navigationTitle("Группы")
        }.navigationViewStyle(.stack)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
