//
//  NewsDetailsAuthorTableViewCell.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 22/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class NewsDetailsAuthorTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadWithNews(news:TopNews){
        self.authorLabel.text = news.author
    }
}
