//
//  MoreTabViewController.swift
//  Cricketly
//
//  Created by BJIT  on 18/2/23.
//

import UIKit


enum MoreTabBarType: CaseIterable {
    case browsePlayers
}

class MoreTabViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    let navigationMap: [MoreTabBarType: MoreTabNavigationCellModel] = [
        .browsePlayers: MoreTabNavigationCellModel(title: "Browse players", image: UIImage(systemName: "figure.cricket"), routeID: .browsePlayersViewController)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: MoreTabNavigationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MoreTabNavigationTableViewCell.identifier)
    }
    
    
}

extension MoreTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MoreTabBarType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreTabNavigationTableViewCell.identifier, for: indexPath) as! MoreTabNavigationTableViewCell
        
        let currentTab = MoreTabBarType.allCases[indexPath.row]
        guard let model = navigationMap[currentTab] else { return cell }
        
        cell.setMoreTabCellModel(model: model)
        
        return cell
    }

}
