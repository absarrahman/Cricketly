//
//  BrowsePlayerViewController.swift
//  Cricketly
//
//  Created by BJIT  on 18/2/23.
//

import UIKit
import Combine

class BrowsePlayerViewController: UIViewController {
    
    
    @IBOutlet weak var searchField: SearchField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = BrowsePlayersViewModel()
    
    var playersList: [SquadCollectionCellModel] = []
    
    var cancellables: Set<AnyCancellable> = []
    
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        collectionView.dataSource = self
        // collectionView.delegate = self
        collectionView.collectionViewLayout = gridLayout
        
        collectionView.register(UINib(nibName: SquardPlayerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SquardPlayerCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: SquadPlayerCollectionHeaderView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SquadPlayerCollectionHeaderView.identifier)
        
        searchField.textfield.delegate = self
        
        viewModel.getAllPlayers()
        setupBinders()
        
    }
    
    func setupBinders() {
        viewModel.$playerModels.sink {[weak self] players in
            guard let self = self else {
                return
            }
            self.playersList = players
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
}

extension BrowsePlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquardPlayerCollectionViewCell.identifier, for: indexPath) as! SquardPlayerCollectionViewCell
        let model = playersList[indexPath.row]
        cell.setSquadPlayerCellModel(model: model)
        return cell
    }
    
    
}

extension BrowsePlayerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchPlayers(query: textField.text ?? "")
    }
}
