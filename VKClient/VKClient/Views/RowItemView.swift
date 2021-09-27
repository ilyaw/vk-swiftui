//
//  RowItemView.swift
//  VKClient
//
//  Created by Ilya on 27.09.2021.
//

import SwiftUI

struct RowItemView: View {
    
    let photo: Image
    let text: String
    
    var body: some View {
        HStack {
            photo
                .resizable()
                .aspectRatio(contentMode: .fill)
                .modifier(CircleView())
                .frame(width: 55, height: 55)
            Text(text)
        }
    }
}


struct RowItemView_Previews: PreviewProvider {
    static var previews: some View {
        RowItemView(photo: Image("ilya1"), text: "Илья Руденко")
    }
}
