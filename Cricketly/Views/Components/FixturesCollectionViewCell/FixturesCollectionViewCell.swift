//
//  FixturesCollectionViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit
import SDWebImage

struct FixtureCellModel {
    let isLive: Bool
    let localTeamCode: String
    let visitorTeamCode: String
    let localTeamRun: String
    let visitorTeamRun: String
    let localTeamWicket: String
    let visitorTeamWicket: String
    let localTeamOver: String
    let visitorTeamOver: String
    let matchNote: String
    let matchType: String
    let localTeamImageUrl: String
    let visitorTeamImageUrl: String
    
}

class FixturesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FixturesCollectionViewCell"
    
    @IBOutlet weak private var rootView: UIView!
    
    
    @IBOutlet weak private var liveView: UIView!
    
    
    @IBOutlet weak private var cellTitle: UILabel!
    

    @IBOutlet weak private var localTeamImageView: UIImageView!
    
    
    @IBOutlet weak private var vistorTeamImageView: UIImageView!
    
    
    
    @IBOutlet weak private var localTeamCodeLabel: UILabel!
    
    
    @IBOutlet weak private var visitorTeamCodeLabel: UILabel!
    
    
    @IBOutlet weak private var localTeamScore: UILabel!
    
    
    @IBOutlet weak private var visitorTeamScore: UILabel!
    
    
    
    @IBOutlet weak private var localTeamOverLabel: UILabel!
    
    
    @IBOutlet weak private var vistorTeamOverLabel: UILabel!
    
    
    @IBOutlet weak private var matchNoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootView.layer.cornerRadius = 10
    }
    
    func setup(model:FixtureCellModel) {
        liveView.alpha = model.isLive ? 1 :0
        
        cellTitle.text = model.matchType
        
        // IMAGES
        localTeamImageView.sd_setImage(with: URL(string: model.localTeamImageUrl), placeholderImage: nil,options: .progressiveLoad)
        vistorTeamImageView.sd_setImage(with: URL(string: model.visitorTeamImageUrl), placeholderImage: nil,options: .progressiveLoad)
        
        // TEAM CODE
        localTeamCodeLabel.text = model.localTeamCode
        visitorTeamCodeLabel.text = model.visitorTeamCode
        
        // scores
        localTeamScore.text = "\(model.localTeamRun)/\(model.localTeamWicket)"
        visitorTeamScore.text = "\(model.visitorTeamRun)/\(model.visitorTeamWicket)"
        
        // overs
        localTeamOverLabel.text = "\(model.localTeamOver) overs"
        vistorTeamOverLabel.text = "\(model.visitorTeamOver) overs"
        
        // note
        matchNoteLabel.text = model.matchNote
    }

}
