//
//  GroupInfo.swift
//  VKClient
//
//  Created by Ilya on 29.10.2021.
//

import Foundation

struct GroupResponseInfo: Codable {
    let response: [GroupInfo]
}

class GroupInfo: Codable {
    var id: Int
    var membersCount: Int?
    var activity: String?
    
    enum GroupKeys: String, CodingKey {
        case id
        case membersCount = "members_count"
        case activity
    }
    
    required init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: GroupKeys.self)
        
        let id = try response.decode(Int.self, forKey: .id)
        let membersCount = try? response.decode(Int.self, forKey: .membersCount)
        let activity = try? response.decode(String.self, forKey: .activity)
        
        self.id = id
        self.membersCount = membersCount
        self.activity = activity
    }
}
