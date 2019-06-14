//
//  NewsNetworkManager.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation
import Alamofire

class NewsNetworkManager
{
    
//    static func getAllNews(_ completion: @escaping BoolCompletion) {
//
//        DispatchQueue.global().async {
//
//            Alamofire.request("https://newsapi.org/v2/top-headlines?country=pl&apiKey=4bde5c7fe94946268a3b1894e488286d").responseJSON(completionHandler: { response in
//
//                if let json = response.result.value as? [String: Any] {
//                    TopNews.parseJsonToRealm(json: json, isFromSearch: false)
//
//                }
//
//                DispatchQueue.main.async {
//                    completion(response.result.isSuccess)
//                }
//
//            })
//
//        }
//    }
    
    static func getTopNewsFromCountry(country:String,_ completion: @escaping BoolCompletion) {
        
        DispatchQueue.global().async {
            
            Alamofire.request("https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=4bde5c7fe94946268a3b1894e488286d").responseJSON(completionHandler: { response in
                
                if let json = response.result.value as? [String: Any] {
                    TopNews.parseJsonToRealm(json: json, isFromSearch: false, selectedCountry: country)
                    
                }
                
                DispatchQueue.main.async {
                    completion(response.result.isSuccess)
                }
                
            })
            
        }
    }
    
    static func getInterestingNews(text:String,_ completion: @escaping BoolCompletion) {
        let destUrl = "https://newsapi.org/v2/everything?q=\(text)&apiKey=4bde5c7fe94946268a3b1894e488286d"
        
        DispatchQueue.global().async {
            
            Alamofire.request(destUrl).responseJSON(completionHandler: { response in
                
                if let json = response.result.value as? [String: Any] {
                    TopNews.parseJsonToRealm(json: json,isFromSearch: true,selectedCountry: nil)
                    
                }
                
                DispatchQueue.main.async {
                    completion(response.result.isSuccess)
                }
                
            })
            
        }
    }
}

