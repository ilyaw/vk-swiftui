//
//  Photos.swift
//  VKClient
//
//  Created by Ilya on 29.10.2021.
//

import Foundation
import RealmSwift

struct RootPhotos: Codable {
    let response: PhotosResponse
}

struct PhotosResponse: Codable {
    let count: Int
    let items: [Photo]
}

class Photo: Object, Codable, Identifiable {
    @objc dynamic var albumID: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    var sizes = List<Size>()
    @objc dynamic var text: String = ""
    var likes: Likes?
    var reposts: Reposts?
    var comments: Comments?
    
    var getLikesCount: Int {
        return likes?.count ?? 0
    }
    
    var getCommentsCount: Int {
        return comments?.count ?? 0
    }
    
    var getRepostsCount: Int {
        return reposts?.count ?? 0
    }
    
    var averageSize: String? {
        return sizes.first { $0.type == .x }?.url ?? sizes.last?.url
    }

    var isLike: Bool {
        return likes?.isLike ?? false
    }
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case likes, reposts, comments
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Photo {
            return self.albumID == object.albumID && self.text == object.text
        } else {
            return false
        }
    }

    override class func primaryKey() -> String? {
        "id"
    }
}

struct Comments: Codable {
    let count: Int
}

struct Reposts: Codable {
    let count: Int
}

class Likes: Codable {

    enum CodingKeys: String, CodingKey {
        case isLike = "user_likes"
        case count
    }

    let isLike: Bool
    let count: Int

    required init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)

        let isLike = try? decoder.decode(Int.self, forKey: .isLike)
        let count = try? decoder.decode(Int.self, forKey: .count)

        self.isLike = isLike == 1 ? true : false
        self.count = count ?? 0
    }
}


class Size: Object, Codable {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    var type: TypeEnum
    @objc dynamic var width: Int = 0
}


//Тип размера
enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

enum TypeAlbum: String {
    case wall = "wall"  //фото со стены
    case profile = "profile" //фотографии профиля
    case saved = "saved" //сохраненные фотографии.
}

enum TypeRev: Int {
    case chronological = 0
    case antiСhronological = 1
}
