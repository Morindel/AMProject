//
//  TopNewsRealmManager.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//


import Foundation
import RealmSwift

class TopNewsRealmManager {
    
    static func getAllTopNews(country :String?,completion: @escaping ArrayItemCompletion<TopNews>) {
        
        DispatchQueue.global().async {
            
            guard let realm = Realm.currentRealm() else {
                NSLog("%@: realm error", #function)
                
                DispatchQueue.main.async {
                    completion([])
                }
                
                return
            }
            
            var array = [TopNews]()
            
            let articles = realm.objects(TopNews.self).filter("isFromSearching = false AND selectedCountry = %@",country ?? "")
            for news in articles {
                array.append(TopNews(value: news))
            }
            
            DispatchQueue.main.async {
                completion(array)
            }
        }
    }
    
    static func getAllFavourite(completion: @escaping ArrayItemCompletion<TopNews>) {
        
        DispatchQueue.global().async {
            
            guard let realm = Realm.currentRealm() else {
                NSLog("%@: realm error", #function)
                
                DispatchQueue.main.async {
                    completion([])
                }
                
                return
            }
            
            var array = [TopNews]()
            
            let articles = realm.objects(TopNews.self).filter("isFavourite == true")
            for news in articles {
                array.append(TopNews(value: news))
            }
            
            DispatchQueue.main.async {
                completion(array)
            }
        }
    }
}
