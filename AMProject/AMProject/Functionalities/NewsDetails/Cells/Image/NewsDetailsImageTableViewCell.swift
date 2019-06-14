//
//  NewsDetailsImageTableViewCell.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit
import Kingfisher

class NewsDetailsImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadWithImage(imageURL:String?){
        guard let url = imageURL else { return }
        
        let resource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
       
        self.newsImageView.kf.indicatorType = .activity
        self.newsImageView.kf.setImage(with: resource)
    }
    
}
