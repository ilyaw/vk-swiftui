//
//  PhotoView.swift
//  VKClient
//
//  Created by Ilya on 30.10.2021.
//

import SwiftUI
import Kingfisher

struct PhotoView: View {
    let photo: Photo
    
    var body: some View {
        if let url = photo.averageSize {
            GeometryReader { proxy in
                KFImage(URL(string: url))
                    .cancelOnDisappear(true)
                    .resizable()
//                    .frame(width: proxy.size.width, height: proxy.size.width)
                    .aspectRatio(contentMode: .fill)
              
            }
        }
    }
}
