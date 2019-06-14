//
//  TopNews.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TopNews : Object {
    //    @objc dynamic var id = 0
    @objc dynamic var author : String?
    @objc dynamic var content : String?
    @objc dynamic var descritpion : String?
    @objc dynamic var publishedAt: String?
    @objc dynamic var title : String?
    @objc dynamic var urlToImage : String?
    @objc dynamic var url : String? = ""
    @objc dynamic var isFromSearching: Bool = false
    @objc dynamic var isFavourite: Bool = false
    @objc dynamic var selectedCountry: String?
    
    
    override static func primaryKey() -> String? {
        return "url"
    }
    //    //Impl. of Mappable protocol
    //    required convenience init?(map: Map) {
    //        self.init()
    //    }
    //    func mapping(map: Map) {
    //        url <- map["url"]
    //        author <- map["author"]
    //        content <- map["content"]
    //        descritpion <- map["descritpion"]
    //        publishedAt <- map["publishedAt"]
    //        title <- map["title"]
    //        urlToImage <- map["urlToImage"]
    //    }
    
    
    
}
