//
//  MatchInfoViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 15/2/23.
//

import UIKit
import Combine
class MatchInfoViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = MatchDetailsViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    var parentVC: MatchDetailsViewController!
    //var
    
    var seriesCellList: [MatchInfoTableViewCellModel] = []
    var venueCellList: [MatchInfoTableViewCellModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get match info
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MatchInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MatchInfoTableViewCell.identifier)
        parentVC = self.parent as? MatchDetailsViewController
        print("PARENT VC ID IS \(parentVC.selectedFixtureId)")
        setupBinders()
        viewModel.fetchMatchInfo(id: parentVC.selectedFixtureId ?? -1)
    }

    
    func setupBinders() {
        viewModel.$venueImageUrl.sink { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.parentVC.backgroundImageView.sd_setImage(with: URL(string: result ?? ""), placeholderImage: UIImage(named: "placeholderImage"),options: .progressiveLoad)
        }.store(in: &cancellables)
        
        viewModel.$seriesInfoCellDataList.sink { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            self.seriesCellList = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
        
        viewModel.$venueInfoCellDataList.sink { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.venueCellList = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    
}

extension MatchInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchInfoTableViewCell.identifier, for: indexPath) as! MatchInfoTableViewCell
        
        let model: MatchInfoTableViewCellModel
        
        if (indexPath.section == 0) {
            model = seriesCellList[indexPath.row]
        } else {
            model = venueCellList[indexPath.row]
        }
        
        cell.setInfoCellModel(infoModel: model)
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return seriesCellList.count
        } else {
            return venueCellList.count
        }
    }
    
    
}

extension MatchInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}
