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
            GeometryReader { _ in
                KFImage(URL(string: url))
                    .cancelOnDisappear(true)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .clipped()
        }
    }
}
