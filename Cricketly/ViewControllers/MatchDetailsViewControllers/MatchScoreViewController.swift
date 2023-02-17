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
    
    @IBOutlet weak var localTeamNameLabel: UILabel!
    
    
    @IBOutlet weak var visitorTeamNameLabel: UILabel!
    
    
    var firstTeamBattingCellModels: [ScoreTableViewCellModel] = []
    var secondTeamBattingCellModels: [ScoreTableViewCellModel] = []
    var firstTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    var secondTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        toggleSwitch.isOn = false
        setLabelVisibility(toggleSwitch.isOn)
        parentVC = self.parent as? MatchDetailsViewController
        print("PARENT VC ID IS \(parentVC.selectedFixtureId)")
        viewModel.fetchMatchScore(id: parentVC.selectedFixtureId ?? -1)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ScoreboardTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ScoreboardTableViewCell.identifier)
        tableView.register(UINib(nibName: ScoreboardHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ScoreboardHeaderView.identifier)
        setupBinders()
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        toggleSwitch.isOn = false
//        setLabelVisibility(toggleSwitch.isOn)
//        parentVC = self.parent as? MatchDetailsViewController
//        print("PARENT VC ID IS \(parentVC.selectedFixtureId)")
//        viewModel.fetchMatchScore(id: parentVC.selectedFixtureId ?? -1)
//        tableView.reloadData()
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Clear data
//        firstTeamBattingCellModels = []
//        secondTeamBattingCellModels = []
//        firstTeamBowlingCellModels = []
//        secondTeamBowlingCellModels = []
//
//    }
    
    fileprivate func setLabelVisibility(_ isSelected: Bool) {
        if (isSelected) {
            visitorTeamNameLabel.alpha = 1
            localTeamNameLabel.alpha = 0.5
        } else {
            visitorTeamNameLabel.alpha = 0.5
            localTeamNameLabel.alpha = 1
        }
    }
    
    @IBAction func switchButtonTapped(_ sender: UISwitch) {
        setLabelVisibility(toggleSwitch.isOn)
        tableView.reloadData()
    }
    
    
    func setupBinders() {
        
        // Set names
        
        viewModel.$localTeamName.sink {[weak self] name in
            guard let self = self else {
                return
            }
            self.localTeamNameLabel.text = name
        }.store(in: &cancellables)
        
        viewModel.$visitorTeamName.sink {[weak self] name in
            guard let self = self else {
                return
            }
            self.visitorTeamNameLabel.text = name
        }.store(in: &cancellables)
        
        
        // LOCAL TEAM
        viewModel.$firstTeamBattingCellModels.sink {[weak self] result in
            guard let self = self else {
                return
            }
            self.firstTeamBattingCellModels = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
        
        viewModel.$secondTeamBowlingCellModels.sink {[weak self] result in
            guard let self = self else {
                return
            }
            self.secondTeamBowlingCellModels = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
        
        // VISITOR TEAM
        
        viewModel.$secondTeamBattingCellModels.sink {[weak self] result in
            guard let self = self else {
                return
            }
            self.secondTeamBattingCellModels = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
        
        viewModel.$firstTeamBowlingCellModels.sink {[weak self] result in
            guard let self = self else {
                return
            }
            self.firstTeamBowlingCellModels = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }

}

extension MatchScoreViewController: UITableViewDataSource {
    fileprivate func getListBasedOnToggle(_ section: Int) -> [ScoreTableViewCellModel] {
        if (toggleSwitch.isOn) {
            if (section == 0) {
                return secondTeamBattingCellModels
            } else {
                return firstTeamBowlingCellModels
            }
        } else {
            if (section == 0) {
                return firstTeamBattingCellModels
            } else {
                return secondTeamBowlingCellModels
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getListBasedOnToggle(section).count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        (firstTeamBattingCellModels.isEmpty && secondTeamBattingCellModels.isEmpty && firstTeamBowlingCellModels.isEmpty && secondTeamBowlingCellModels.isEmpty) ? 0 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreboardTableViewCell.identifier, for: indexPath) as! ScoreboardTableViewCell
        
        let modelList = getListBasedOnToggle(indexPath.section)
        
        let model = modelList[indexPath.row]
        cell.setPlayerModel(model: model)
        return cell
    }
    
    
}

extension MatchScoreViewController: UITableViewDelegate {
    fileprivate func getHeaderView(type: ScoreboardHeaderViewType) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScoreboardHeaderView.identifier) as! ScoreboardHeaderView
        headerView.layer.cornerRadius = 10
        headerView.clipsToBounds = true
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        headerView.setSectionLabelType(type: type)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            return getHeaderView(type: .batting)
        default:
            return getHeaderView(type: .bowling)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 0.3, delay: 0.1 * Double(indexPath.row) / 3.5, options: [.curveEaseInOut], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}
