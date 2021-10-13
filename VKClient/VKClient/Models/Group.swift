//
//  Group.swift
//  VKClient
//
//  Created by Ilya on 28.09.2021.
//

import Foundation

struct Group: Identifiable {
    let id: Int
    let groupName: String
    let postOwnerImage: String
    let membersCount: Int
    let activity: String
    var shortInfo: String {
        let text = String.localizedStringWithFormat(NSLocalizedString("members count", comment: ""),
                                                    membersCount)
        return "\(activity), \(text)"
    }
}

func getGroups() -> [Group] {
    [Group(id: 1, groupName: "/dev/null", postOwnerImage: "group1", membersCount: 310941, activity: "Программирование"),
    Group(id: 2, groupName: "Команда ВКонтакте", postOwnerImage: "group2", membersCount: 128126, activity: "ВКонтакте"),
    Group(id: 3, groupName: "СберКот", postOwnerImage: "group3", membersCount: 4081494, activity: "Открытая группа"),
    Group(id: 4, groupName: "ох уж этот интернет", postOwnerImage: "group4", membersCount: 90897, activity: "Юмор"),
    Group(id: 5, groupName: "Amazing GoPro", postOwnerImage: "group5", membersCount: 775997, activity: "Туризм, путешествия")]
}
