//
//  SquardPlayerCollectionViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 17/2/23.
//

import UIKit
import SDWebImage

struct SquadCollectionCellModel: Equatable, Hashable {
    let id: Int
    let name: String
    let position: String
    let isCaptain: Bool
    let isWicketKeeper: Bool
    let imageUrl: String
    
    static func == (lhs: SquadCollectionCellModel, rhs: SquadCollectionCellModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class SquardPlayerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SquardPlayerCollectionViewCell"
    
    
    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var rightView: UIView!
    
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightContentLabel: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    
    
    @IBOutlet weak var leftContentLabel: UILabel!
    
    
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leftImageView.layer.cornerRadius = leftImageView.bounds.height / 2
        rightImageView.layer.cornerRadius = rightImageView.bounds.height / 2
    }
    
    func setSquadPlayerCellModel(model: SquadCollectionCellModel, isLeft: Bool = true) {
        
        leftView.alpha = isLeft ? 1 : 0
        rightView.alpha = isLeft ? 0 : 1
        
        let title = "\(model.name) \(model.isCaptain ? "(C)" : "") \(model.isWicketKeeper ? "(Wk)": "")"
        
        let content = model.position
        
        if isLeft {
            leftTitleLabel.text = title
            leftContentLabel.text = content
            leftImageView.sd_setImage(with: URL(string: model.imageUrl),placeholderImage: UIImage(named: "placeholder"), options: .progressiveLoad)
        } else {
            rightTitleLabel.text = title
            rightContentLabel.text = content
            rightImageView.sd_setImage(with: URL(string: model.imageUrl),placeholderImage: UIImage(named: "placeholder"), options: .progressiveLoad)
        }
        
    }
    
}
