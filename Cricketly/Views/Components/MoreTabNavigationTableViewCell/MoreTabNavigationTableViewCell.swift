//
//  MoreTabNavigationTableViewCell.swift
//  Cricketly
//
//  Created by BJIT  on 18/2/23.
//

import UIKit

struct MoreTabNavigationCellModel {
    let title: String
    let image: UIImage?
    let routeID: RouteMap
}

class MoreTabNavigationTableViewCell: UITableViewCell {
    
    static let identifier = "MoreTabNavigationTableViewCell"
    
    @IBOutlet weak var navigationImageView: UIImageView!
    
    
    @IBOutlet weak var navigationTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMoreTabCellModel(model: MoreTabNavigationCellModel) {
        
        navigationTitle.text = model.title
        navigationImageView.image = model.image
        
    }
    
}
