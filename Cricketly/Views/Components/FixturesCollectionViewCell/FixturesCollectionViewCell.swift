//
//  FixturesCollectionViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit

class FixturesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FixturesCollectionViewCell"
    
    @IBOutlet weak var rootView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootView.layer.cornerRadius = 10
    }

}
