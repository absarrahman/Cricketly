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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
    
        section.boundarySupplementaryItems = [header]
        
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        return compositionalLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = gridLayout
        
        collectionView.register(UINib(nibName: SquardPlayerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SquardPlayerCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: SquadPlayerCollectionHeaderView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SquadPlayerCollectionHeaderView.identifier)
        
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

extension MatchSquadViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1, delay: 0.07 * Double(indexPath.row) / 3.5, options: [.curveEaseInOut], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SquadPlayerCollectionHeaderView.identifier, for: indexPath)
        return headerView
    }
    
    
}

extension MatchSquadViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
        
    }
}
