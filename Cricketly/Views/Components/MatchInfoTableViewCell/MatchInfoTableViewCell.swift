//
//  MatchInfoTableViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import UIKit


struct MatchInfoTableViewCellModel {
    let title: String
    let content: String
}

class MatchInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MatchInfoTableViewCell"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfoCellModel(infoModel: MatchInfoTableViewCellModel) {
        titleLabel.text = infoModel.title
        contentLabel.text = infoModel.content
    }
}
