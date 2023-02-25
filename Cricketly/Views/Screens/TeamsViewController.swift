//
//  TeamsViewController.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import UIKit
import Combine

class TeamsViewController: UIViewController {
    
    let viewModel = TeamViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    
    @IBOutlet weak var searchTextField: SearchField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var gridLayout : UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.125)), subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        
        
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        return compositionalLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = gridLayout
        
        title = "Teams"
        
        searchTextField.textfield.delegate = self
        collectionView.register(UINib(nibName: SquardPlayerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SquardPlayerCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: SquadPlayerCollectionHeaderView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SquadPlayerCollectionHeaderView.identifier)
        
        viewModel.fetchTeamData()
        setupBinders()
    }
    
    func setupBinders() {
        viewModel.$loadingStatus.sink {[weak self] loadingStatus in
            guard let self = self else {
                return
            }
            if (loadingStatus == .finished) {
                print(self.viewModel.teamsData)
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CommonFunctions.setNavBarAttributes(navigationController: navigationController)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TeamsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filteredTeamData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquardPlayerCollectionViewCell.identifier, for: indexPath) as! SquardPlayerCollectionViewCell
        let model = viewModel.filteredTeamData[indexPath.row]
        cell.setSquadPlayerCellModel(model: model)
        return cell
    }
    
    
}

extension TeamsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Routes.getViewControllerBy(routeMap: .teamSquadViewController) as! TeamSquadViewController

        let id = viewModel.teamsData[indexPath.row].id
        vc.id = id

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TeamsViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchTeam(query: textField.text ?? "")
        collectionView.reloadData()
    }
}
