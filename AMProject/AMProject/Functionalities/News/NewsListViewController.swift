//
//  NewsListViewController.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 20/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

enum NewsTypes : Int {
    case NewsListTopType = 0, NewsListSearchType, NewsListFavouriteType
}
class NewsListViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    //
    // MARK: - Properties
    //
    var newsArray = [TopNews]()
    var newsType : NewsTypes!
    var textToSearch : String!
    var selectedCountry : String!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //
    // MARK: - Initalization
    //
    
    
    static func newsIntanceForFavourite(newsType:NewsTypes) -> UIViewController {
        let storyboard = UIStoryboard(name: "NewsList", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewsList") as? NewsListViewController else {
            return UIViewController()
        }
        
        viewController.newsType = newsType
        
        return viewController
    }
    
    static func newInstanceWithSelectedCountry(newsType:NewsTypes,country:String) -> UIViewController {
        let storyboard = UIStoryboard(name: "NewsList", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewsList") as? NewsListViewController else {
            return UIViewController()
        }
        
        viewController.newsType = newsType
        viewController.selectedCountry = country
        
        return viewController
    }
    
    static func newInstanceWithText(newsType:NewsTypes,text:String) -> UIViewController {
        let storyboard = UIStoryboard(name: "NewsList", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewsList") as? NewsListViewController else {
            return UIViewController()
        }
        
        viewController.newsType = newsType
        viewController.textToSearch = text
        
        return viewController
    }
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         if(self.newsType.rawValue == NewsTypes.NewsListFavouriteType.rawValue){
            self.loadData()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.registerCell()
        
        if(self.newsType.rawValue == NewsTypes.NewsListTopType.rawValue){
            self.synchronizeList()
        } else {
            self.loadData()
        }
        
        self.title = "newsList".localized()
        self.noDataLabel.text = "noData".localized()
        
    }
    
    //
    // MARK - LoadData
    //
    
    func synchronizeList() {
        showLoadingView()
        
        NewsSynchronizationManager.sharedInstance.synchronizeWithSelectedCountry(country: self.selectedCountry, completion: { [weak self] synchronizationResult in
            if synchronizationResult == SynchronizationResult.synchronized ||
                synchronizationResult == SynchronizationResult.skipped {
                self?.loadData()
            } else {
                self?.hideLoadingView()
            }
        })
    }
    
    func loadData() {
        showLoadingView()
        
        switch self.newsType.rawValue {
            
        case NewsTypes.NewsListTopType.rawValue:
            
            TopNewsRealmManager.getAllTopNews(country: self.selectedCountry, completion: { [weak self] news in
                self?.newsArray = news
                
                self?.shouldShowNoData()
                self?.tableView.reloadData()
                self?.hideLoadingView()
            })
            
            return
            
        case NewsTypes.NewsListSearchType.rawValue:
            NewsNetworkManager.getInterestingNews(text: self.textToSearch) { (Bool) in
                self.hideLoadingView()
                
                let realm = try! Realm()
                var articles = realm.objects(TopNews.self).filter("isFromSearching == true AND isFavourite == false")
                
                articles = articles.sorted(byKeyPath: "publishedAt", ascending: false)
                self.newsArray = Array(articles)
                
                self.shouldShowNoData()
                self.tableView.reloadData()
            
            return
            }
            
            
        case NewsTypes.NewsListFavouriteType.rawValue:
            TopNewsRealmManager.getAllFavourite( completion: { [weak self] news in
                self?.newsArray = news
                
                self?.shouldShowNoData()
                self?.tableView.reloadData()
                self?.hideLoadingView()
            })
            
        default:
            return
            
        }
    }
            
    
    func shouldShowNoData(){
        if(newsArray.count == 0){
            self.tableView.separatorStyle = .none
            self.noDataView.isHidden = false
        } else {
            self.noDataView.isHidden = true
        }
    }
    
    //
    // MARK: - Appereance
    //
    
    func registerCell(){
        tableView.register(UINib.init(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as! NewsListTableViewCell
        
        cell.loadWithNews(news: newsArray[indexPath.row])
        
        if let image = newsArray[indexPath.row].urlToImage{
            guard let url = URL(string: image) else {
                return cell
            }
            let resource = ImageResource(downloadURL: url, cacheKey: image)
            
            cell.articleImageVIew.kf.indicatorType = .activity
            cell.articleImageVIew.kf.setImage(with: resource)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let news = newsArray[indexPath.row]
        let viewController = NewsDetailsViewController.newInstanceWithNews(news)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
