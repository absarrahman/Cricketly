//
//  MatchesViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit

class MatchesViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var listLabel = [
        "0", "1", "2"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(segmentedControl.numberOfSegments)
        segmentedControl.defaultConfiguration(font: UIFont.systemFont(ofSize: 10), color: .red)
        segmentedControl.selectedConfiguration(font: UIFont.systemFont(ofSize: 17), color: .white)
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        testLabel.text = listLabel[sender.selectedSegmentIndex]
    }
}
