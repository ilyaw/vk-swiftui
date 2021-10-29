//
//  FriendsViewModel.swift
//  VKClient
//
//  Created by Ilya on 26.10.2021.
//

import Foundation
import RealmSwift

class FriendsViewModel: ObservableObject {
  
    var detachedFriends: [FriendItem] { realmFriends?.map { $0.detached() } ?? [] }
   
    let realmService: AnyRealmService
    let networkManager: AnyNetworkSerivce
    
    private var notificationToken: NotificationToken?
    let objectWillChange = ObjectWillChangePublisher()
    var error: Error?
    
    private lazy var realmFriends: Results<FriendItem>? = try? realmService.get(FriendItem.self, configuration: .deleteIfMigration).sorted(byKeyPath: "firstName")
    
    init(realmService: AnyRealmService, networkManager: AnyNetworkSerivce) {
        self.realmService = realmService
        self.networkManager = networkManager
        
        subscribeForDatabaseChanges()
    }
    
    private func subscribeForDatabaseChanges() {
        notificationToken = realmFriends?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func fetchFriends() {
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        networkManager.getFriends(userId: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                try? self.realmService.save(items: friends,
                                            configuration: .deleteIfMigration,
                                            update: .modified)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
