//
//  MatchDetailsSectionLabelCollectionViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 15/2/23.
//

import UIKit


struct MatchDetailsSectionCollectionCellModel {
    let sectionTitle: String
    let isSelected: Bool
}

class MatchDetailsSectionLabelCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MatchDetailsSectionLabelCollectionViewCell"

    
    @IBOutlet weak private var sectionLabel: UILabel!
    
    @IBOutlet weak private var circularView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCellModel(model: MatchDetailsSectionCollectionCellModel) {
        sectionLabel.text = model.sectionTitle
        circularView.alpha = model.isSelected ? 1 : 0
    }

}
