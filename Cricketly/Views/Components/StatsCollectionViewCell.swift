//
//  StatsCollectionViewCell.swift
//  Cricketly
//
//  Created by BJIT  on 26/2/23.
//

import UIKit


class StatsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StatsCollectionViewCell"

    @IBOutlet weak var rootView: UIView!
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootView.applyShadow(cornerRadius: 10)
        applyShadow(cornerRadius: 10)
    }
    
    func setModelDataInCell(model: MatchInfoTableViewCellModel) {
        topLabel.text = model.title
        bottomLabel.text = model.content
    }

}
