//
//  DetailPhotoView.swift
//  VKClient
//
//  Created by Ilya on 06.11.2021.
//

import SwiftUI
import Kingfisher

struct DetailPhotoView: View {
    
    let photos: [Photo]
    
    @State var isLike: Bool = false
    @State private var currentPage: Int
    @State private var dragCompleted = false
    
    private var currentPhoto: Photo {
        return photos[currentPage]
    }
    
    init (photos: [Photo], index: Int) {
        self.photos = photos
        self.currentPage = index
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                if let url = currentPhoto.averageSize {
                    KFImage(URL(string: url))
                        .cancelOnDisappear(true)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding()
                }
            }
            Spacer()
            PageControl(current: currentPage, maxPhotosCount: photos.count)
            HStack {
                Spacer()
                HStack {
                    if isLike {
                        Image("like_pressed")
                    } else {
                        Image("like")
                    }
                    Text("\(currentPhoto.getLikesCount)")
                }.onTapGesture {
                    withAnimation(.easeInOut) {
                        isLike.toggle()
                    }
                }
                Spacer()
                HStack {
                    Image("comment")
                    Text("\(currentPhoto.getCommentsCount)")
                }
                Spacer()
                HStack {
                    Image("share")
                    Text("\(currentPhoto.getRepostsCount)")
                }
                Spacer()
            }.padding(10)
        } .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
            if value.translation.width < 0 {
                if currentPage < photos.count {
                    withAnimation(.spring()) {
                        currentPage += 1
                    }
                }
            }
            if value.translation.width > 0 {
                if currentPage != 0 {
                    withAnimation(.spring()) {
                        currentPage -= 1
                    }
                }
            }
            isLike = false
        }))
    }
}


struct PageControl: UIViewRepresentable {
    
    var current = 0
    var maxPhotosCount: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .black
        page.numberOfPages = maxPhotosCount
        page.pageIndicatorTintColor = .gray
        return page
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = current
    }
}
