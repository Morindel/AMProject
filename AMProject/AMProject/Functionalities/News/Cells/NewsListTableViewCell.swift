//
//  NewsListTableViewCell.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 20/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var articleImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadWithNews(news : TopNews?){
        
        if let title = news?.title{
            titleLabel.text = title
        } else {
            titleLabel.text = nil
        }
        
        if let author = news?.author{
            authorLabel.text = author
        } else {
            authorLabel.text = nil
        }
    
    }
}
