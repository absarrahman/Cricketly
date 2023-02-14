//
//  MatchDetailsViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import UIKit

class MatchDetailsViewController: UIViewController {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let vc = MatchInfoViewController()
        setContainerViewController(containerViewController: vc, containerView: containerView)
    }

}
