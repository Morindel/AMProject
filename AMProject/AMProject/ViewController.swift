//
//  ViewController.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 20/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        if let vc = UIStoryboard(name: "NewsList", bundle: nil).instantiateViewController(withIdentifier: "NewsList") as? NewsListViewController
        {
            present(vc, animated: true, completion: nil)
        }

                                                                            
    }
    
}

