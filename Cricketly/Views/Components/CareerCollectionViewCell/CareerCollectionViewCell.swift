//
//  CareerCollectionViewCell.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import UIKit

class CareerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CareerCollectionViewCell"
    
    
    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet var infoLabelCollection: [UILabel]!
    
    
    @IBOutlet var titleLabelCollection: [UILabel]!
    
    let bowlingLabels = [
        "W",
        "Mat",
        "O.",
        "Inn.",
        "Avg.",
        "Econ.",
        "M",
        "R",
        "Wd",
        "Nb",
        "SR"
    ]
//    "matches": 14,
//                        "innings": 14,
//                        "runs_scored": 201,
//                        "not_outs": 6,
//                        "highest_inning_score": 38,
//                        "strike_rate": 148.89,
//                        "balls_faced": 135,
//                        "average": 25.13,
//                        "four_x": 17,
//                        "six_x": 6,
//                        "fow_score": 822,
//                        "fow_balls": 110.20000000000002,
//                        "hundreds": 0,
//                        "fifties": 0
    let battingLabels = [
        "R",
        "Inn.",
        "NO",
        "HS",
        "SR",
        "BF",
        "Avg.",
        "4's",
        "6's",
        "50",
        "100",
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootView.layer.cornerRadius = 10
        applyShadow(cornerRadius: 10)
    }
    
    func setCellDataFrom(model: CareerCollectionCellModel, isBowling: Bool = false) {
        var dataScores: [String] = []
        seasonLabel.text = model.careerType
        
        for i in 0..<titleLabelCollection.count {
            if isBowling {
                titleLabelCollection[i].text = bowlingLabels[i]
                
                let bowlingCareer = model.bowlingCareer
            
                
                dataScores = [
                    bowlingCareer.wickets.description,
                    bowlingCareer.matches.description,
                    bowlingCareer.overs.description,
                    bowlingCareer.innings.description,
                    bowlingCareer.average.description,
                    bowlingCareer.econRate.description,
                    bowlingCareer.medians.description,
                    bowlingCareer.runs.description,
                    bowlingCareer.wide.description,
                    bowlingCareer.noBall.description,
                    bowlingCareer.strikeRate.description,
                    
                ]
            } else {
                let battingCareer = model.battingCareer
                titleLabelCollection[i].text = battingLabels[i]
//                "R",
//                "Inn.",
//                "NO",
//                "HS",
//                "SR",
//                "BF",
//                "Avg.",
//                "4's",
//                "6's",
//                "50",
//                "100",
                dataScores = [
                    battingCareer.runsScored.description,
                    battingCareer.innings.description,
                    battingCareer.notOuts.description,
                    battingCareer.highestInningScore.description,
                    battingCareer.strikeRate.description,
                    battingCareer.ballsFaced.description,
                    battingCareer.average.description,
                    battingCareer.fourX.description,
                    battingCareer.sixX.description,
                    battingCareer.fifties.description,
                    battingCareer.hundereds.description
                ]
            }
        }
        
        
        for i in 0..<dataScores.count {
            infoLabelCollection[i].text = dataScores[i]
            print(infoLabelCollection[i].text)
        }
    }

}
