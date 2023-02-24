//
//  PlayerStatsViewController.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import UIKit

class PlayerStatsViewController: UIViewController {
    
    let viewModel = PlayerDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let parentVC = parent as! PlayerDetailsViewController
        viewModel.fetchPlayerStatInfo(id: parentVC.id)
    }

}
