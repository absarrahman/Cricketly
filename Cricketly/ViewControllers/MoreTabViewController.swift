//
//  MoreTabViewController.swift
//  Cricketly
//
//  Created by BJIT  on 18/2/23.
//

import UIKit


enum MoreTabBarType: CaseIterable {
    case browsePlayers, teams, dateFixtures
}

class MoreTabViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    let navigationMap: [MoreTabBarType: MoreTabNavigationCellModel] = [
        .browsePlayers: MoreTabNavigationCellModel(title: "Browse players", image: UIImage(systemName: "figure.cricket"), routeID: .browsePlayersViewController),
        .teams: MoreTabNavigationCellModel(title: "Teams", image: UIImage(systemName: "person.3.fill"), routeID: .teamsViewController),
        .dateFixtures: MoreTabNavigationCellModel(title: "Fixtures", image: UIImage(systemName: "calendar"), routeID: .dateFixturesController)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "More"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 20
        tableView.clipsToBounds = true
        tableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableView.register(UINib(nibName: MoreTabNavigationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MoreTabNavigationTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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

extension MoreTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = navigationMap[MoreTabBarType.allCases[indexPath.row]]!.routeID
        let vc = Routes.getViewControllerBy(routeMap: id)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
