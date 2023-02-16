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
    
    
    var firstTeamBattingCellModels: [ScoreTableViewCellModel] = []
    var secondTeamBattingCellModels: [ScoreTableViewCellModel] = []
    var firstTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    var secondTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        parentVC = self.parent as? MatchDetailsViewController
        print("PARENT VC ID IS \(parentVC.selectedFixtureId)")
        viewModel.fetchMatchScore(id: parentVC.selectedFixtureId ?? -1)
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: ScoreboardTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ScoreboardTableViewCell.identifier)
        setupBinders()
    }
    
    func setupBinders() {
        viewModel.$firstTeamBattingCellModels.sink {[weak self] result in
            guard let self = self else {
                return
            }
            self.firstTeamBattingCellModels = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }

}

extension MatchScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        firstTeamBattingCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreboardTableViewCell.identifier, for: indexPath) as! ScoreboardTableViewCell
        let model = firstTeamBattingCellModels[indexPath.row]
        cell.setPlayerModel(model: model)
        return cell
    }
    
    
}
