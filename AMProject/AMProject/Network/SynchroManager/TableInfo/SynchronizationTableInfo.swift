//
//  SynchronizationTableInfo.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation
import RealmSwift

enum SynchronizationTable: String {
    case news
    
    func synchronizationTimeInterval() -> TimeInterval {
        switch self {
        case .news:
            return 60*60
        }
    }
}

class SynchronizationTableInfo: Object {
    @objc dynamic var name = ""
    @objc dynamic var lastSynchronizationDate: Date?
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    static func updateSynchronizationTime(_ table: SynchronizationTable) {
        
        guard let realm = Realm.currentRealm() else {
            NSLog("%@ realm error", #function)
            return
        }
        
        guard let tableInfo = getTableInfoForName(table.rawValue, realm: realm) else {
            NSLog("%@ couldn't find table with name %@", #function, table.rawValue)
            return
        }
        
        do {
            try realm.write {
                tableInfo.lastSynchronizationDate = Date()
            }
        } catch let error {
            NSLog("%@: %@", #function, error.localizedDescription)
            return
        }
    }
    
    static func shouldSynchronize(_ table: SynchronizationTable) -> Bool {
        
        guard let realm = Realm.currentRealm() else {
            NSLog("%@ realm error", #function)
            return true
        }
        
        guard let tableInfo = getTableInfoForName(table.rawValue, realm: realm) else {
            NSLog("%@ couldn't find table with name %@", #function, table.rawValue)
            return true
        }
        
        if let lastSynchronizationDate = tableInfo.lastSynchronizationDate {
            let shouldSynchronize = Date().timeIntervalSince(lastSynchronizationDate) > table.synchronizationTimeInterval()
            return shouldSynchronize
        } else {
            return true
        }
    }
    
    private static func getTableInfoForName(_ name: String, realm: Realm) -> SynchronizationTableInfo? {
        if let tableInfo = realm.objects(SynchronizationTableInfo.self).filter("name == %@", name).first {
            return tableInfo
        } else {
            
            do {
                var newTableInfo: SynchronizationTableInfo?
                
                try realm.write {
                    newTableInfo = realm.create(SynchronizationTableInfo.self, value: ["name": name])
                }
                
                return newTableInfo
            } catch let error {
                NSLog("%@: %@", #function, error.localizedDescription)
                return nil
            }
        }
    }
}
