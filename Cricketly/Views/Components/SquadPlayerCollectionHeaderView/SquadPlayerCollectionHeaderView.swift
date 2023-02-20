//
//  SquadPlayerCollectionHeaderView.swift
//  Cricketly
//
//  Created by BJIT  on 17/2/23.
//

import UIKit
import SDWebImage


class SquadPlayerCollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "SquadPlayerCollectionHeaderView"
    
    @IBOutlet weak var localTeamImageView: UIImageView!
    
    
    @IBOutlet weak var visitorTeamImageView: UIImageView!
    
    
    
    @IBOutlet weak var localTeamLabel: UILabel!
    
    
    @IBOutlet weak var visitorTeamLabel: UILabel!
    
    
    @IBOutlet weak var rootView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setHeaderViewBasedOn(models: [TeamViewDataModel])  {
        if !models.isEmpty {
            rootView.alpha = 1
            let localTeam = models[0]
            let visitorTeam = models[1]
            localTeamImageView.sd_setImage(with: URL(string: localTeam.teamImgUrl),placeholderImage: UIImage(named: "placeholderImage"), options: .progressiveLoad)
            
            visitorTeamImageView.sd_setImage(with: URL(string: visitorTeam.teamImgUrl),placeholderImage: UIImage(named: "placeholderImage"), options: .progressiveLoad)
            
            localTeamLabel.text = localTeam.teamCode
            visitorTeamLabel.text = visitorTeam.teamCode
        } else {
            rootView.alpha = 0
        }
    }
    
}
