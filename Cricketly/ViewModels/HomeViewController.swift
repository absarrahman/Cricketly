//
//  HomeViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var bannerView: UIView!
    
    
    @IBOutlet weak var bannerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var matchesLabelTopConstraint: NSLayoutConstraint!
    
    var lastContentOffset: CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        UIFunctions.setViewCornerRadius(view: bannerView, cornerRadius: 20, edgeType: [.layerMaxXMinYCorner,.layerMaxXMaxYCorner])
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width * 0.8, height: collectionView.bounds.height * 0.9)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: FixturesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FixturesCollectionViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixturesCollectionViewCell.identifier, for: indexPath) as! FixturesCollectionViewCell
        
        return cell
    }
}


extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Yeet"
        return cell
    }
    
}
extension HomeViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            UIView.animate(withDuration: 0.1, delay: 0) {[weak self] in
                guard let self = self else {
                    return
                }
                if (100 > scrollView.contentOffset.y) {
                    print("Scrolled up")
                    
                    if (self.matchesLabelTopConstraint.constant < 180) {
                        self.bannerTopConstraint.constant += 15
                        self.matchesLabelTopConstraint.constant += 10
                    } else {
                        self.matchesLabelTopConstraint.constant = 180
                        self.bannerTopConstraint.constant = 80
                    }
                    
                } else if (100 < scrollView.contentOffset.y) {
                    print("Scrolled down")
                    if (self.matchesLabelTopConstraint.constant > 0) {
                        self.bannerTopConstraint.constant -= 15
                        self.matchesLabelTopConstraint.constant -= 10
                    } else {
                        self.matchesLabelTopConstraint.constant = 0
                        self.bannerTopConstraint.constant = -500
                    }
                    
                }
            }
            
            //self.lastContentOffset = scrollView.contentOffset.y
        }
}
