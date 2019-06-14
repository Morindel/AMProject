//
//  TopNewsWrapper.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation

class TopNewsWrapper {
    var author : String?
    var content : String?
    var descritpion : String?
    var publishedAt: String?
    var title : String?
    var urlToImage : String?
    var url : String?
    var isFromSearching : Bool?
    var isFavourite : Bool?
    var selectedCountry : String?
    
    init(topNews: TopNews) {
        self.author = topNews.author
        self.content = topNews.content
        self.descritpion = topNews.descritpion
        self.publishedAt = topNews.publishedAt
        self.title = topNews.title
        self.urlToImage = topNews.urlToImage
        self.url = topNews.url
        self.isFavourite = topNews.isFavourite
        self.isFromSearching = topNews.isFromSearching
        self.selectedCountry = topNews.selectedCountry
    }
    
}
