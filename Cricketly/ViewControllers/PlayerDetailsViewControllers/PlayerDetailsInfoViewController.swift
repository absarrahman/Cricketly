//
//  PlayerDetailsInfoViewController.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import UIKit
import Combine

class PlayerDetailsInfoViewController: UIViewController {
    
    let viewModel: PlayerDetailsViewModel = PlayerDetailsViewModel()

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        //tableView.delegate = self
        tableView.register(UINib(nibName: MatchInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MatchInfoTableViewCell.identifier)
        let parentVC = self.parent as? PlayerDetailsViewController
        
        setupBinders()
        viewModel.fetchPlayerInfo(id: parentVC?.id ?? -1)
    }
    
    func setupBinders() {
        viewModel.$loadStatus.sink {[weak self] status in
            
            guard let self = self else {
                return
            }
            
            if status == .finished {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.store(in: &cancellables)
    }


}

extension PlayerDetailsInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.personalInfoCellsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchInfoTableViewCell.identifier, for: indexPath) as! MatchInfoTableViewCell
        let model = viewModel.personalInfoCellsModel[indexPath.row]
        cell.setInfoCellModel(infoModel: model)
        return cell
    }
    
    
}
