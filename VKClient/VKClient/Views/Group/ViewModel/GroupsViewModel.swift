//
//  GroupsViewModel.swift
//  VKClient
//
//  Created by Ilya on 30.10.2021.
//

import Foundation
import RealmSwift

class GroupsViewModel: ObservableObject {
  
    var detachedGroups: [Group] { realmGroups?.map { $0.detached() } ?? [] }
   
    let realmService: AnyRealmService
    let networkManager: AnyNetworkSerivce
    
    private var notificationToken: NotificationToken?
    let objectWillChange = ObjectWillChangePublisher()
    var error: Error?
    
    private lazy var realmGroups: Results<Group>? = try? realmService.get(Group.self, configuration: .deleteIfMigration)
    
    init(realmService: AnyRealmService, networkManager: AnyNetworkSerivce) {
        self.realmService = realmService
        self.networkManager = networkManager
        
        subscribeForDatabaseChanges()
    }
    
    private func subscribeForDatabaseChanges() {
        notificationToken = realmGroups?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func fetchGroups() {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        networkManager.getGroups(userId: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let groups):
                try? self.realmService.save(items: groups,
                                            configuration: .deleteIfMigration,
                                            update: .modified)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
