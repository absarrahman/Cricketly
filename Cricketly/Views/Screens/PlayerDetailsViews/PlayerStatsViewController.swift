//
//  PlayerStatsViewController.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import UIKit
import Combine

class PlayerStatsViewController: UIViewController {
    
    let viewModel = PlayerDetailsViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    
    var gridLayout : UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)), subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        
        
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        return compositionalLayout
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.collectionViewLayout = gridLayout
        
        let parentVC = parent as! PlayerDetailsViewController
        viewModel.fetchPlayerStatInfo(id: parentVC.id)
        collectionView.register(UINib(nibName: StatsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: StatsCollectionViewCell.identifier)
        
        setupBinders()
    }
    
    func setupBinders() {
        viewModel.$loadStatus.sink {[weak self] loadingStatus in
            guard let self = self else {
                return
            }
            if (loadingStatus == .finished) {
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
}


extension PlayerStatsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.playerStat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatsCollectionViewCell.identifier, for: indexPath) as! StatsCollectionViewCell
        let model = viewModel.playerStat[indexPath.row]
        cell.setModelDataInCell(model: model)
        return cell
    }
    
    
}
