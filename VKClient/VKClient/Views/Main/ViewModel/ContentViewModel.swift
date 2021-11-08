//
//  ContentViewModel.swift
//  VKClient
//
//  Created by Ilya on 25.10.2021.
//

import Foundation
import SwiftKeychainWrapper

class ContentViewModel: ObservableObject {
    
    @Published var isUserAuthorized: Bool = false
    private let timeToSecnod: Double = 86400.0
    
    init() {
        checkValidToken()
    }
    
    private func checkValidToken()  {
        if let keychainData = KeychainWrapper.standard.string(forKey: "user") {
            let data = Data(keychainData.utf8)
            
            if let decodeUser = decode(json: data, as: KeychainUser.self) {
             
                let now = Date().timeIntervalSince1970
                let isValidDate = (now - decodeUser.date) < timeToSecnod
                
                if isValidDate {
                    UserDefaults.standard.set(decodeUser.token, forKey: "vkToken")
                    UserDefaults.standard.set(decodeUser.id, forKey: "userId")
                    
                    isUserAuthorized = true
                }
            }
        }
    }
}
