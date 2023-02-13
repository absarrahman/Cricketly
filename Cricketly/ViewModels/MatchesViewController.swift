//
//  MatchesViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit

class MatchesViewController: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(segmentedControl.numberOfSegments)
        segmentedControl.defaultConfiguration(font: UIFont.systemFont(ofSize: 10), color: .red)
        segmentedControl.selectedConfiguration(font: UIFont.systemFont(ofSize: 17), color: .white)
        
        Service.shared.getFixtureById(id: 46199) { result in
            switch result {
            case .success(let data):
                print(data?.firstumpire?.fullname)
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)

    }
}
