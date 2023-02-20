//
//  PlayerDetailsViewController.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import UIKit


enum PlayerSectionTabs: String, CaseIterable {
    case info, career, stats
}

class PlayerDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    @IBOutlet weak var playerCountryNameLabel: UILabel!
    
    
    var selectedVC: UIViewController!
    var selectedTab: PlayerSectionTabs = .info
    
    var sectionsMap: [PlayerSectionTabs:UIViewController] = [
        .info: PlayerDetailsInfoViewController()
    ]
    
    fileprivate func addChildVC(_ vc: UIViewController) {
        selectedVC = vc
        setContainerViewController(containerViewController: vc, containerView: containerView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 20
        collectionView.clipsToBounds = true
        collectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let vc = sectionsMap[.info]!
        addChildVC(vc)
        collectionView.register(UINib(nibName: MatchDetailsSectionLabelCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MatchDetailsSectionLabelCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
extension PlayerDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PlayerSectionTabs.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchDetailsSectionLabelCollectionViewCell.identifier, for: indexPath) as! MatchDetailsSectionLabelCollectionViewCell
        
        let currentSection = PlayerSectionTabs.allCases[indexPath.row]
        
        let model = MatchDetailsSectionCollectionCellModel(sectionTitle: currentSection.rawValue.capitalized, isSelected: currentSection == selectedTab)
        
        cell.setupCellModel(model: model)
        
        return cell
    }
    
}

extension PlayerDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTab = PlayerSectionTabs.allCases[indexPath.row]
        remove(asChildViewController: selectedVC)
        addChildVC(sectionsMap[selectedTab]!)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 1, delay: 0.07 * Double(indexPath.row) / 3.5, options: [.curveEaseInOut], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}
