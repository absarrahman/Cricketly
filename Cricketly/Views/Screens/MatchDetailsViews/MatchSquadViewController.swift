//
//  MatchSquadViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 17/2/23.
//

import UIKit
import Combine


class MatchSquadViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var localTeamSquadCellModels: [SquadCollectionCellModel] = []
    var visitorTeamSquadCellModels: [SquadCollectionCellModel] = []
    var cancellables: Set<AnyCancellable> = []
    let viewModel = MatchDetailsViewModel()
    
    var parentVC: MatchDetailsViewController!
    
    var gridLayout : UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)), subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        return compositionalLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.collectionViewLayout = gridLayout
        collectionView.register(UINib(nibName: SquardPlayerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SquardPlayerCollectionViewCell.identifier)
        
        parentVC = self.parent as? MatchDetailsViewController
        print("PARENT VC ID IS \(parentVC.selectedFixtureId)")
        viewModel.fetchMatchScore(id: parentVC.selectedFixtureId ?? -1)
        setupBinders()
    }
    
    func setupBinders() {
        viewModel.$localTeamSquadCellModels.sink {[weak self] squad in
            guard let self = self else {
                return
            }
            self.localTeamSquadCellModels = squad
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }.store(in: &cancellables)
        
        viewModel.$visitorTeamSquadCellModels.sink {[weak self] squad in
            guard let self = self else {
                return
            }
            
            self.visitorTeamSquadCellModels = squad
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
    }

}

extension MatchSquadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        localTeamSquadCellModels.count + visitorTeamSquadCellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquardPlayerCollectionViewCell.identifier, for: indexPath) as! SquardPlayerCollectionViewCell
        let index = Int(indexPath.row / 2)
        
        let model = (indexPath.row % 2 == 0) ? localTeamSquadCellModels[index] : visitorTeamSquadCellModels[index]
        
        cell.setSquadPlayerCellModel(model: model, isLeft: indexPath.row % 2 == 0)
        
        
        
        return cell
    }
    
    
}
