//
//  NewsDetailsDescriptionTableViewCell.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class NewsDetailsDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadWithNews(news:TopNews){
        self.descriptionLabel.text = news.content ?? ""
    }
}
