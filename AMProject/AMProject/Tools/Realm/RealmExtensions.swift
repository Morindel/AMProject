//
//  RealmExtensions.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    static func currentRealm() -> Realm? {
        do {
            let realm = try Realm()
            realm.refresh()
            return realm
        } catch let error as NSError {
            NSLog("Realm error: %@", error.debugDescription)
            return nil
        }
    }
}
