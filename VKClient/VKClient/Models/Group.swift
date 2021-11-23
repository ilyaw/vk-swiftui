//
//  Groups.swift
//  VKClient
//
//  Created by Ilya on 29.10.2021.
//

import Foundation
import RealmSwift

class Group: Object, Identifiable {
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var isMember: Bool = false
    @objc dynamic var photo: String = ""
    @objc dynamic var activity: String = ""
    
    convenience init(id: Int,
                     name: String,
                     isMember: Bool,
                     photo: String,
                     activity: String) {
        self.init()
        
        self.id = id
        self.name = name
        self.isMember = isMember
        self.photo = photo
        self.activity = activity
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Group {
            return self.name == object.name
            && self.photo == object.photo
            && self.activity == object.activity
        }
        return true
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class GroupList: Decodable {
    var amount: Int = 0
    var models: [Group] = []
    
    var isMember: Int?
    
    enum ResponseCodingKeys: String, CodingKey {
        case response
    }
    
    enum ItemsCodingKeys: String, CodingKey {
        case count
        case items
    }
    
    enum GroupKeys: String, CodingKey {
        case id
        case isMember = "is_member"
        case name
        case photo100 = "photo_100"
        case activity
    }
    
    required init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let values = try response.nestedContainer(keyedBy: ItemsCodingKeys.self, forKey: .response)
        
        let count = try values.decode(Int.self, forKey: .count)
        self.amount = count
        
        var items = try values.nestedUnkeyedContainer(forKey: .items)
        
        let itemsCount: Int = items.count ?? 0
        for _ in 0..<itemsCount {
            let groupContainer = try items.nestedContainer(keyedBy: GroupKeys.self)
            let id = try groupContainer.decode(Int.self, forKey: .id)
            let name = try groupContainer.decode(String.self, forKey: .name)
            let activity = try? groupContainer.decode(String.self, forKey: .activity)
            
            let isMemberInt = try? groupContainer.decode(Int.self, forKey: .isMember)
            var isMemberBool = false
            
            if let isMemberInt = isMemberInt {
                isMemberBool = isMemberInt == 0 ? false : true
            }
            
            let photo = try groupContainer.decode(String.self, forKey: .photo100)
            
            let group = Group(id: id,
                              name: name,
                              isMember: isMemberBool,
                              photo: photo,
                              activity: activity ?? "")
            
         
            self.models.append(group)
        }
    }
}

struct GroupResponse: Codable {
    let response: Int
}
