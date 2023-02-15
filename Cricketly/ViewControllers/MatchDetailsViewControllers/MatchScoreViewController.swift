//
//  MatchScoreViewController.swift
//  Cricketly
//
//  Created by BJIT  on 15/2/23.
//

import UIKit
import Combine

class MatchScoreViewController: UIViewController {
    
    let viewModel = MatchDetailsViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    var parentVC: MatchDetailsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        parentVC = self.parent as? MatchDetailsViewController
        print("PARENT VC ID IS \(parentVC.selectedFixtureId)")
        viewModel.fetchMatchScore(id: parentVC.selectedFixtureId ?? -1)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
