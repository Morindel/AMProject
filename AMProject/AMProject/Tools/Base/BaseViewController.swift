//
//  BaseViewController.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingView: LoadingView?
    
    func showLoadingView() {
        if loadingView == nil {
            loadingView = LoadingView.showInView(self.view)
        }
    }
    
    func hideLoadingView() {
        if let loadingView = loadingView {
            loadingView.hide()
            self.loadingView = nil
        }
    }
    
    func wasSelectedInMenu() {
        
    }
    
}
