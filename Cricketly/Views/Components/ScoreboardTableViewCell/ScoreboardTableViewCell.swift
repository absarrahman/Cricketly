//
//  ScoreboardTableViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 16/2/23.
//

import UIKit
import SDWebImage

struct ScoreTableViewCellModel {
    let id: Int
    let imgUrl: String
    let playerName: String
    let playerNote: String
    let stackInfos: [String?]
}

class ScoreboardTableViewCell: UITableViewCell {
    
    static let identifier = "ScoreboardTableViewCell"
    
    
    @IBOutlet weak var rootView: UIView!
    
    
    @IBOutlet weak var playerCellImageView: UIImageView!
    
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    @IBOutlet weak var scoreNoteLabel: UILabel!
    
    
    @IBOutlet var stackInfoLabels: [UILabel]!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        rootView.layer.cornerRadius = 10
        playerCellImageView.layer.cornerRadius = playerCellImageView.frame.height / 2
    }
    
    func setPlayerModel(model: ScoreTableViewCellModel) {
        playerCellImageView.sd_setImage(with: URL(string: model.imgUrl), placeholderImage: UIImage(named: "placeholderImage"),options: .progressiveLoad)
        playerNameLabel.text = model.playerName
        scoreNoteLabel.text = model.playerNote
        
        print(stackInfoLabels.count,model.stackInfos)
        for i in (0..<stackInfoLabels.count) {
            stackInfoLabels[i].text = model.stackInfos[i] ?? ""
        }
    }
    
}
