//
//  NewsListViewController.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 20/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    let networkRequest = EventsNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        networkRequest.getNews() { responseObject, error in
            print("responseObject = \(String(describing: responseObject)); error = \(String(describing: error))")
            return
        }
        
    }
    
}
