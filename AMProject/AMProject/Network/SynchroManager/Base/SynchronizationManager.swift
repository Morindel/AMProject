//
//  SynchronizationManager.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation

enum SynchronizationResult {
    case synchronized
    case skipped
    case failed
}

typealias SynchronizationCompletion = (SynchronizationResult) -> Void

class SynchronizationManager {
    
    var inProgress = false
    var completions = [SynchronizationCompletion]()
    
    func shouldSynchronize() -> Bool {
        return true
    }
    
    func synchronize(completion: @escaping SynchronizationCompletion) {
        
    }
    
    func synchronizeWithSelectedCountry(country:String,completion: @escaping SynchronizationCompletion) {
    
    }
    
    func notifyCompletionsWithResult(_ synchronizationResult: SynchronizationResult) {
        for completion in completions {
            completion(synchronizationResult)
        }
        
        completions.removeAll()
    }
    
    func updateSynchronizationTime() {
        
    }
}
