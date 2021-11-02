//
//  GroupDetailView.swift
//  VKClient
//
//  Created by Ilya on 28.09.2021.
//

import SwiftUI

struct GroupDetailView: View {
    
    let group: Group
    
    var body: some View {
        Text(group.name)
    }
}

//struct GroupDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupDetailView(group: getGroups().first!)
//    }
//}
