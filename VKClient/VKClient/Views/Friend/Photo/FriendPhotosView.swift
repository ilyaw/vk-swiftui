//
//  FriendPhotosView.swift
//  VKClient
//
//  Created by Ilya on 27.09.2021.
//

import SwiftUI
import ASCollectionView

struct FriendPhotosView: View {

    @ObservedObject var viewModel = FriendPhotoViewModel(networkManager: NetworkSerivce())
    let friend: Friend
    
    var body: some View {
        VStack {
            ASCollectionView(data: viewModel.photos) { (photo, context) in
                PhotoView(photo: photo)
            }.layout {
//                .grid(
//                    layoutMode: .fixedNumberOfColumns(2),
//                    itemSpacing: 5,
//                    lineSpacing: 5)
                
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                let width = UIScreen.main.bounds.width / 2
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                layout.itemSize = CGSize(width: width, height: width)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
                layout.scrollDirection = .vertical
                return layout
            }
            .onAppear {
                viewModel.fetchPhotos(for: friend)
            }
        }
    }
}

//struct FriendDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendPhotosView(friendModel: getFriends().first!)
//    }
//}
