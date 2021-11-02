//
//  KeychainUser.swift
//  VKClient
//
//  Created by Ilya on 20.10.2021.
//

import Foundation

struct KeychainUser: Codable {
    let id: Int
    let token: String
    let date: TimeInterval
}
