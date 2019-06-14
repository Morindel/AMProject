//
//  MenuViewController.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 20/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate {
 
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var halfTransparentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewWithPicker: UIView!
    
    @IBOutlet weak var countryChooseLabel: UILabel!
    
    @IBOutlet weak var topNewsButton: UIButton!
    @IBOutlet weak var searchNewsButton: UIButton!
    
    @IBOutlet weak var favouriteNews: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    let countries = ["UnitedStates".localized() : "us",
                      "Poland".localized() :"pl"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTranslations()
    }
    
    //
    //MARK:SETUP
    //
    
    func setTranslations () {
        self.topNewsButton.setTitle("topNews".localized(), for: UIControl.State.normal)
        self.searchNewsButton.setTitle("searchNews".localized(), for: UIControl.State.normal)
        self.selectButton.setTitle("select".localized(), for: UIControl.State.normal)
        self.cancelButton.setTitle("cancel".localized(), for: UIControl.State.normal)
        self.favouriteNews.setTitle("favouriteArticles".localized(), for: UIControl.State.normal)
        
        self.titleLabel.text = "selectTitle".localized()
        self.countryChooseLabel.text = "chooseCountry".localized()
    }

    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.scrollView.isScrollEnabled = true
    }
    //
    //MARK:PickerView
    //
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(countries)[row].key
    }
    
    func hideViewWithPicker() {
        self.halfTransparentView.isHidden = true
        self.viewWithPicker.isHidden = true
        self.halfTransparentView.alpha = 0.0
    }
    
    func showViewWithPicker() {
        self.halfTransparentView.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.halfTransparentView.alpha = 0.55
        }, completion: { (finished:Bool) in
            self.viewWithPicker.isHidden = false
        })
    }
    
    //
    //MARK:ButtonAction
    //
    
    @IBAction func topNewsButtonClicked(_ sender: Any) {
        
        self.showViewWithPicker()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        
        self.hideViewWithPicker()
    }
    
    @IBAction func selectButtonClicked(_ sender: Any) {
        
        let viewController = NewsListViewController.newInstanceWithSelectedCountry(newsType: NewsTypes.NewsListTopType, country: Array(countries)[self.pickerView.selectedRow(inComponent: 0)].value)
        self.navigationController?.pushViewController(viewController, animated: true)
        
        self.hideViewWithPicker()
    }
    
    @IBAction func searchNews(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "inputKeyword".localized(), preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "searcharticles".localized(), style: .default) { (alertAction) in
            _ = alert.textFields![0] as UITextField
            if(alert.textFields?[0].text == ""){
                return
            }
            if let text = alert.textFields?[0].text
            {
            let viewController = NewsListViewController.newInstanceWithText(newsType: NewsTypes.NewsListSearchType,text:text)
                self.navigationController?.pushViewController(viewController, animated: true)}
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "articlekeyword".localized()
        }
        
        alert.addAction(action)
        
      
        self.present(alert, animated: true, completion:nil)
    }
    
    @IBAction func showFavouriteNews(_ sender: Any) {
        
        let viewController = NewsListViewController.newsIntanceForFavourite(newsType: NewsTypes.NewsListFavouriteType)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}


