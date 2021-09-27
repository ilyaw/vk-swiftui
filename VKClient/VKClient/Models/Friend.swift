//
//  Friend.swift
//  VKClient
//
//  Created by Ilya on 27.09.2021.
//

import Foundation

struct Friend: Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let mainPhoto: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

func getFriends() -> [Friend] {
    [Friend(id: 1, firstName: "Илья", lastName: "Руденко", mainPhoto: "ilya1"),
     Friend(id: 2, firstName: "Денис", lastName: "Чувакин", mainPhoto: "den1"),
     Friend(id: 3, firstName: "Ваня", lastName: "Горностаев", mainPhoto: "vanya1"),
     Friend(id: 4, firstName: "Лиза", lastName: "Притула", mainPhoto: "liza1"),
     Friend(id: 5, firstName: "Михаил", lastName: "Мендельсон", mainPhoto: "mikh1")]
}
