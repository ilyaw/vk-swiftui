//
//  NewsfeedView.swift
//  VKClient
//
//  Created by Ilya on 17.10.2021.
//

import SwiftUI

struct NewsfeedView: View {
    
    var body: some View {
//        NavigationView {
            VStack {
                CustomLoader()
            }
//            .navigationTitle("Новостная лента")
//        }
//        .navigationViewStyle(.stack)
    }
}

struct NewsfeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsfeedView()
    }
}
