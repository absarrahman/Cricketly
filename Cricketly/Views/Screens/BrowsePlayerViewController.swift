//
//  BrowsePlayerViewController.swift
//  Cricketly
//
//  Created by BJIT  on 18/2/23.
//

import UIKit

class BrowsePlayerViewController: UIViewController {
    
    
    @IBOutlet weak var searchField: SearchField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var gridLayout : UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.125)), subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//
    
        //section.boundarySupplementaryItems = [header]
        
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        return compositionalLayout
    }
    
    
    var playersList: [PlayerRealmModel] = []
    
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
        playersList = RealmDBManager.shared.read(type: PlayerRealmModel.self).sorted(by: { p1, p2 in
            //p1.fullname ?? "" < p2.fullname ?? ""
            guard let p1Name = p1.fullname, let p2Name = p2.fullname else { return false }
            return p1Name < p2Name
        })
        
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
        cell.rightTitleLabel.text = playersList[indexPath.row].fullname
        cell.rightContentLabel.text = playersList[indexPath.row].countryName
        return cell
    }
    
    
}
