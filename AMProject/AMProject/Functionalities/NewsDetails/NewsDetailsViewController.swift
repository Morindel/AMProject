//
//  NewsDetailsViewController.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

enum NewsDetailsSection  : Int {
    case NewsDetailsImageSection = 0, NewsDetailsTitleSection, NewsDetailsDescriptionSection, NewsDetailsDescriptionMore, NewsDetailsAuthorSection, NewsDetailsSectionCount
}

class NewsDetailsViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //
    // MARK: - Properties
    //
    
    var newsDetails = TopNews()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //
    // MARK: - Initalization
    //
    
    static func newInstanceWithNews(_ news: TopNews) -> UIViewController {
        let storyboard = UIStoryboard(name: "NewsDetails", bundle: nil)
        
        guard let viewController = storyboard.instantiateInitialViewController() as? NewsDetailsViewController else {
            return UIViewController()
        }
        viewController.newsDetails = news
        
        return viewController
    }
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.showButtton(isFavourite: self.isFavourite(news: self.newsDetails))
        
        self.registerCell()
        self.setOrientation()
        self.setTranslations()
        
    }
    
    //
    //MARK:Setup
    //
    
    func setTranslations() {
    self.deleteButton.setTitle("deleteFromFavourite".localized(), for: UIControl.State.normal)
        self.addButton.setTitle("addToFavourite".localized(), for: UIControl.State.normal)
        self.title = "newsDetails".localized()
    }
    
    func setOrientation() {
        
        let device =  UIDevice.current
        device.beginGeneratingDeviceOrientationNotifications()
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(self.orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    //
    // MARK: - Appereance
    //
    
    func registerCell(){
        tableView.register(UINib.init(nibName: "NewsDetailsImageTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsDetailsImageTableViewCell")
        tableView.register(UINib.init(nibName: "NewsDetailsTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsDetailsTitleTableViewCell")
        tableView.register(UINib.init(nibName: "NewsDetailsDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsDetailsDescriptionTableViewCell")
        tableView.register(UINib.init(nibName: "NewsDetailsMoreInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsDetailsMoreInformationTableViewCell")
        tableView.register(UINib.init(nibName: "NewsDetailsAuthorTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsDetailsAuthorTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case NewsDetailsSection.NewsDetailsImageSection.rawValue:
            if newsDetails.urlToImage != nil{
                return 1
            }
            return 0
            
        case NewsDetailsSection.NewsDetailsTitleSection.rawValue:
            if newsDetails.title != nil {
                return 1
            }
            return 0
            
        case NewsDetailsSection.NewsDetailsDescriptionSection.rawValue:
            if newsDetails.content != nil{
                return 1
            }
            return 0
            
            
        case NewsDetailsSection.NewsDetailsDescriptionMore.rawValue:
            if newsDetails.url != nil{
                return 1
            }
            return 0
            
        case NewsDetailsSection.NewsDetailsAuthorSection.rawValue:
            if newsDetails.author != nil{
                return 1
            }
            return 0
            
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewsDetailsSection.NewsDetailsSectionCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case NewsDetailsSection.NewsDetailsImageSection.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsImageTableViewCell", for: indexPath) as! NewsDetailsImageTableViewCell
            cell.loadWithImage(imageURL: self.newsDetails.urlToImage)
            
            return cell
            
        case NewsDetailsSection.NewsDetailsTitleSection.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsTitleTableViewCell", for: indexPath) as! NewsDetailsTitleTableViewCell
            cell.loadWithNews(news: newsDetails)
            
            return cell
            
        case NewsDetailsSection.NewsDetailsDescriptionSection.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsDescriptionTableViewCell", for: indexPath) as! NewsDetailsDescriptionTableViewCell
            cell.loadWithNews(news: newsDetails)
            
            return cell
            
        case NewsDetailsSection.NewsDetailsDescriptionMore.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsMoreInformationTableViewCell", for: indexPath) as! NewsDetailsMoreInformationTableViewCell
            cell.loadWithNews(news: newsDetails)
            
            return cell
            
        case NewsDetailsSection.NewsDetailsAuthorSection.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsAuthorTableViewCell", for: indexPath) as!     NewsDetailsAuthorTableViewCell
            cell.loadWithNews(news: newsDetails)
            
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    //
    //MARK:ACTIONS
    //
    
    @objc func orientationChanged() {
        self.tableView.setContentOffset(.zero, animated: true)
    }
    
    func setFavourite(news:TopNews){
        let realm = try! Realm()
        
        let object = realm.object(ofType: TopNews.self, forPrimaryKey: news.url)
        
        try! realm.write {
            object?.isFavourite = true
        }
        
    }
    
    func deleteFromFavourite(news:TopNews){
        let realm = try! Realm()
        
        let object = realm.object(ofType: TopNews.self, forPrimaryKey: news.url)
        
        try! realm.write {
            object?.isFavourite = false
        }
    }
    
    func isFavourite(news:TopNews) -> Bool{
        
        let realm = try! Realm()
        
        let object = realm.object(ofType: TopNews.self, forPrimaryKey: news.url)
        return object?.isFavourite ?? false

    }
    
    func showButtton(isFavourite:Bool) {
        if(isFavourite){
            self.addButton.isHidden = true
            self.deleteButton.isHidden = false
        } else {
            self.addButton.isHidden = false
            self.deleteButton.isHidden = true
        }
    }
    @IBAction func addToFavouriteClicked(_ sender: Any) {
        self.setFavourite(news: self.newsDetails)
        self.showButtton(isFavourite: self.isFavourite(news: self.newsDetails))
    }
    
    @IBAction func deleteFromFavouriteButtonClicked(_ sender: Any) {
        self.deleteFromFavourite(news: self.newsDetails)
        self.showButtton(isFavourite: self.isFavourite(news: self.newsDetails))
    }
    
    
}
