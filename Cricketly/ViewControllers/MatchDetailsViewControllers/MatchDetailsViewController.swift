//
//  MatchDetailsViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import UIKit
import SDWebImage
import Combine

class MatchDetailsViewController: UIViewController {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    let viewModel = MatchDetailsViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    var selectedFixtureId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 20
        collectionView.clipsToBounds = true
        collectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        // TODO: Keep all container vc in one list
        let vc = MatchInfoViewController()
        setContainerViewController(containerViewController: vc, containerView: containerView)
        collectionView.register(UINib(nibName: MatchDetailsSectionLabelCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MatchDetailsSectionLabelCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
    }

}

extension MatchDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchDetailsSectionLabelCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    
}
