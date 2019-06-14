//
//  NewsDetailsTitleTableViewCell.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 21/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import UIKit

class NewsDetailsTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadWithNews (news:TopNews){
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = news.publishedAt {
            if let  dat = df.date(from: date){
                self.dateLabel.text = df.string(from:dat)}
        } else {
            dateLabel.text = nil
        }
        
        self.titleLabel.text = news.title
    }
    
}
