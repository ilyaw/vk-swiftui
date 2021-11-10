//
//  FriendPhotoViewModel.swift
//  VKClient
//
//  Created by Ilya on 30.10.2021.
//

import Foundation

class FriendPhotoViewModel: ObservableObject {
   
    @Published var photos: [Photo] = []
    let networkManager: AnyNetworkSerivce
    
    init(networkManager: AnyNetworkSerivce) {
        self.networkManager = networkManager
    }
    
    private var albums: [Album] = [] {
        didSet {
            getPhotoFromAlbums()
        }
    }
    
    func fetchPhotos(for user: Friend) {
        networkManager.getAlbums(userId: user.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.albums = albums
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getPhotoFromAlbums() {
    
        for album in albums {
            if let ownerId = album.ownerID, let albumId = album.id {
                networkManager.getPhotos(ownerId: ownerId, albumId: albumId) { [weak self] result in
                    switch result {
                    case .success(let photos):
                        self?.photos.append(contentsOf: photos)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
