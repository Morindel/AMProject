//
//  NewsDetailsMoreInformationTableViewCell.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class NewsDetailsMoreInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var moreInfoTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadWithNews(news:TopNews){
        guard let url = news.url else {
            return
        }
        self.moreInfoTextView.text =
            "newsMore".localized() + "\n" + url
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
