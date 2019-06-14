//
//  TopNewsSynchroManager.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation

class NewsSynchronizationManager: SynchronizationManager {
    
    static var selectedCountry = ""
    static let sharedInstance = NewsSynchronizationManager()
    
    override func synchronizeWithSelectedCountry(country:String,completion: @escaping SynchronizationCompletion) {
        completions.append(completion)
        
        if(NewsSynchronizationManager.selectedCountry == country){
        guard !inProgress else {
            return
        }
        
        guard shouldSynchronize() else {
            notifyCompletionsWithResult(.skipped)
            return
            }}
        
        inProgress = true
        
        NewsNetworkManager.getTopNewsFromCountry(country: country, { [weak self] isSuccess in
            self?.inProgress = false
            NewsSynchronizationManager.selectedCountry = country
            
            if isSuccess {
                self?.updateSynchronizationTime()
                self?.notifyCompletionsWithResult(.synchronized)
            } else {
                self?.notifyCompletionsWithResult(.failed)
            }
        })
    }
    
    override func shouldSynchronize() -> Bool {
        return SynchronizationTableInfo.shouldSynchronize(.news)
    }

    override func updateSynchronizationTime() {
        SynchronizationTableInfo.updateSynchronizationTime(.news)
    }
}
