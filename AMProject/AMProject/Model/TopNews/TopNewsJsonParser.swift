//
//  TopNewsJsonParser.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import RealmSwift

extension TopNews {
    
    static func parseJsonToRealm(json: [String: Any],isFromSearch:Bool, selectedCountry:String?) {
        
        guard let realm = Realm.currentRealm() else {
            NSLog("%@ realm error", #function)
            return
        }
        
        if let articlesFromJson = json["articles"] as? [[String : AnyObject]]{
            
            try! realm.write {
                let result = realm.objects(TopNews.self).filter("isFromSearching == true AND isFavourite == false")
                realm.delete(result)
            }
            
            for article in articlesFromJson{
                print(article)
                let articleForArray = TopNews()
                if let title = article["title"] as? String, let author = article["author"] as? String, let desc = article["description"] as? String, let url = article["url"] as? String, let urlToImage = article["urlToImage"] as? String, let content = article["content"] as? String, let publishedAt = article["publishedAt"] as? String{
                    
                    articleForArray.author = author
                    articleForArray.descritpion = desc
                    articleForArray.title = title
                    articleForArray.url = url
                    articleForArray.urlToImage = urlToImage
                    articleForArray.content = content
                    articleForArray.publishedAt = publishedAt
                    articleForArray.isFromSearching = isFromSearch
                    if let country = selectedCountry{
                        articleForArray.selectedCountry = country}
                    
                    try! realm.write {
                        
                        realm.create(TopNews.self,value:articleForArray, update: true)
                    }
                    
                }
            }}
        
        
        
        
    }
}
