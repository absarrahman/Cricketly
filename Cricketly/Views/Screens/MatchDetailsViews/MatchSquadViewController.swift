//
//  MatchSquadViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 17/2/23.
//

import UIKit

class MatchSquadViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: SquardPlayerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SquardPlayerCollectionViewCell.identifier)
    }

}

extension MatchSquadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquardPlayerCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    
}
