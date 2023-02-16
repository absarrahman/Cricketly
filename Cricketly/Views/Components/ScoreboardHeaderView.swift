//
//  ScoreboardHeaderView.swift
//  Cricketly
//
//  Created by BJIT  on 16/2/23.
//

import UIKit

class ScoreboardHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "ScoreboardHeaderView"
    
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    @IBOutlet var stackLabels: [UILabel]!
    
    
    let battingStackLabels = ["R", "B", "4S", "6S", "SR"]
    let bowlingStackLabels = ["O", "M", "R", "W", "ER"]
    
    func setSectionLabelType(type: ScoreboardHeaderViewType) {
        sectionHeaderLabel.text = type.rawValue.capitalized
        
        for index in 0..<stackLabels.count {
            if (type == .batting) {
                stackLabels[index].text = battingStackLabels[index]
            } else {
                stackLabels[index].text = bowlingStackLabels[index]
            }
        }
        
    }
    
}

enum ScoreboardHeaderViewType:String {
    case batting, bowling
}
