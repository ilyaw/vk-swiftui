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
    
    @State private var scalingFactor: CGFloat = 1
    
    var body: some View {
        HStack {
            if let photoUrl = photoUrl {
                KFImage(URL(string: photoUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .modifier(CircleView())
                    .modifier(ReversingScale(to: scalingFactor, onEnded: {
                        DispatchQueue.main.async {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.scalingFactor = 1
                            }
                        }
                    }))
                    .frame(width: 55, height: 55)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.scalingFactor = 0.5
                        }
                        
                    }
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
}
