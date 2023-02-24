//
//  FixturesCollectionViewCell.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit
import SDWebImage

struct FixtureCellModel {
    let id: Int
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
    let isUpcoming: Bool
    
}

class FixturesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FixturesCollectionViewCell"
    
    @IBOutlet weak private var rootView: UIView!
    
    
    @IBOutlet weak private var liveView: UIView!
    
    
    @IBOutlet weak private var cellTitle: UILabel!
    

    @IBOutlet weak var localTeamImageView: UIImageView!
    
    
    @IBOutlet weak private var vistorTeamImageView: UIImageView!
    
    
    
    @IBOutlet weak private var localTeamCodeLabel: UILabel!
    
    
    @IBOutlet weak private var visitorTeamCodeLabel: UILabel!
    
    
    @IBOutlet weak private var localTeamScore: UILabel!
    
    
    @IBOutlet weak private var visitorTeamScore: UILabel!
    
    
    
    @IBOutlet weak private var localTeamOverLabel: UILabel!
    
    
    @IBOutlet weak private var vistorTeamOverLabel: UILabel!
    
    
    @IBOutlet weak private var matchNoteLabel: UILabel!
    
    var countdownTimer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootView.layer.cornerRadius = 10
        applyShadow(cornerRadius: 10)
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
        localTeamScore.text = model.localTeamRun.isEmpty ? "" : "\(model.localTeamRun)/\(model.localTeamWicket)"
        visitorTeamScore.text = model.visitorTeamRun.isEmpty ? "" : "\(model.visitorTeamRun)/\(model.visitorTeamWicket)"
        
        // overs
        localTeamOverLabel.text = model.localTeamOver.isEmpty ? "" : "\(model.localTeamOver) overs"
        vistorTeamOverLabel.text = model.visitorTeamOver.isEmpty ? "" : "\(model.visitorTeamOver) overs"
        
        // Show the user that it is calculating
        matchNoteLabel.text = "Calculating ETA..."
        // note
        if (model.isUpcoming) {
            startTimer(time: model.matchNote)
        } else {
            matchNoteLabel.text = model.matchNote
        }
    }
    
    func startTimer(time: String) {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] timer in
            
            guard let self = self else {
                return
            }
            self.updateTime(time: time)
            
        }
    }
    
    func removeMinusFrom(text: String) -> String {
        var text = text
        text.remove(at: text.startIndex)
        return text
    }
    
    func updateTime(time: String) {
        let difference = CommonFunctions.getDifference(from: time)
        matchNoteLabel.text = "\(CommonFunctions.dateComponentFormatter.string(for: difference) ?? "")"
        if let firstCharacter = matchNoteLabel.text?.first {
            matchNoteLabel.text = firstCharacter == "-" ? "Match started \(removeMinusFrom(text: matchNoteLabel.text ?? "")) ago" : "\(matchNoteLabel.text ?? "") left"
        }
        
        
        guard let differenceTime = difference else { return endTimer() }
        if let date = Calendar.current.date(from: differenceTime) {
            let timeInterval = date.timeIntervalSince1970
            if timeInterval == 0 {
                endTimer()
            }
        }
        
    }
    
    func endTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        endTimer()
    }
    
    

}
