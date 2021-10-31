//
//  Albums.swift
//  VKClient
//
//  Created by Ilya on 29.10.2021.
//

import Foundation

struct RootAlbums: Codable {
    let response: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let count: Int
    let items: [Album]
}

struct Album: Codable {
    let id, thumbID, ownerID, size: Int?
    let title, itemDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case thumbID = "thumb_id"
        case ownerID = "owner_id"
        case title
        case itemDescription = "description"
        case size
    }
}
