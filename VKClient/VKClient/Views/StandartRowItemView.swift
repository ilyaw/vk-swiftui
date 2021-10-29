//
//  StandartRowItemView.swift
//  VKClient
//
//  Created by Ilya on 27.09.2021.
//

import SwiftUI
import Kingfisher

struct StandartRowItemView: View {
    
    let photoUrl: String?
    let text: String
    var subtext: String? = nil
    
    var body: some View {
        HStack {
            KFImage(URL(string: photoUrl ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .modifier(CircleView())
                .frame(width: 55, height: 55)
            VStack(alignment: .leading) {
                Text(text)
                if let subtext = subtext {
                    Text(subtext)
                        .font(.system(size: 16))
                        .foregroundColor(Color.subtext)
                }
            } .padding(.leading, 5)
        }
    }
}


//struct StandartRowItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        StandartRowItemView(photo: Image("group1"), text: "Group Name", subtext: "1234 участников")
//    }
//}
