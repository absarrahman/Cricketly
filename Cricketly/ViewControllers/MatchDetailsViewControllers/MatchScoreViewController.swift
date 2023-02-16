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
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        parentVC = self.parent as? MatchDetailsViewController
        print("PARENT VC ID IS \(parentVC.selectedFixtureId)")
        viewModel.fetchMatchScore(id: parentVC.selectedFixtureId ?? -1)
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: ScoreboardTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ScoreboardTableViewCell.identifier)
    }

}

extension MatchScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreboardTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    
}
