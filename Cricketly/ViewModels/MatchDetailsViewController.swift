//
//  MatchDetailsViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import UIKit

class MatchDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MatchInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MatchInfoTableViewCell.identifier)
    }

}

extension MatchDetailsViewController: UITableViewDelegate {
    
}

extension MatchDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchInfoTableViewCell.identifier, for: indexPath)
        return cell
    }
    
}

extension MatchDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            UIView.animate(withDuration: 0.1, delay: 0) {[weak self] in
                guard let self = self else {
                    return
                }
                if (100 > scrollView.contentOffset.y) {
                    print("Scrolled up")
                    
                    if (self.collectionViewTopConstraint.constant < 140) {
                        self.collectionViewTopConstraint.constant += 10
                    } else {
                        self.collectionViewTopConstraint.constant = 140
                    }
                    
                } else if (100 < scrollView.contentOffset.y) {
                    print("Scrolled down")
                    if (self.collectionViewTopConstraint.constant > 0) {
                        self.collectionViewTopConstraint.constant -= 10
                    } else {
                        self.collectionViewTopConstraint.constant = 0
                    }
                    
                }
            }
            
            //self.lastContentOffset = scrollView.contentOffset.y
        }
}
