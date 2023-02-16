//
//  SquardPlayerCollectionViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 17/2/23.
//

import UIKit

class SquardPlayerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SquardPlayerCollectionViewCell"
    
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leftImageView.layer.cornerRadius = leftImageView.bounds.height / 2
        rightImageView.layer.cornerRadius = rightImageView.bounds.height / 2
    }

}
