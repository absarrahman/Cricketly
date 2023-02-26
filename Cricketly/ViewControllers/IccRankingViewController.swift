//
//  IccRankingViewController.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import UIKit

class IccRankingViewController: UIViewController {
    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        segmentedControl.defaultConfiguration(font: UIFont.systemFont(ofSize: 10), color: .kPrimaryActionColor!)
        segmentedControl.selectedConfiguration(font: UIFont.systemFont(ofSize: 17), color: .white)
    }


}
