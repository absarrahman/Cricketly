//
//  NewsTypeOneTableViewCell.swift
//  News App
//
//  Created by Moh. Absar Rahman on 20/1/23.
//

import UIKit
import SDWebImage

class NewsTypeOneTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTypeOneTableViewCell"
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    @IBOutlet weak var sourceTitleLabel: UILabel!
    
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    
    
    @IBOutlet weak var authorTitleLabel: UILabel!
    
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        newsImageView.layer.cornerRadius = 15
    }
    
    func setBackgroundImageFrom(urlString: String) {
        newsImageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil, options: [.progressiveLoad])
    }
    
    func setNewsModel(model: Article) {
        setBackgroundImageFrom(urlString: model.urlToImage ?? "")
        sourceTitleLabel.text = model.source?.name
        newsTitleLabel.text = model.title
        authorTitleLabel.text = model.author
        dateLabel.text = CommonFunctions.postedBefore(date: model.publishedAt)
        
    }
    
}
