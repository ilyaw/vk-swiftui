//
//  Realm.Configuration+Ext.swift
//  VKClient
//
//  Created by Ilya on 29.10.2021.
//

import RealmSwift

extension Realm.Configuration {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
}
