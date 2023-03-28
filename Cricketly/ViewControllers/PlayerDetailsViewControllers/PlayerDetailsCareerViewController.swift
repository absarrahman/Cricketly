//
//  PlayerDetailsCareerViewController.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import UIKit
import Combine

class PlayerDetailsCareerViewController: UIViewController {
    
    let viewModel = PlayerDetailsViewModel()
    
    var cancellables: Set<AnyCancellable> = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: collectionView.bounds.width * 0.85, height: 200)
        
        layout.minimumLineSpacing = 40
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CareerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CareerCollectionViewCell.identifier)
        
        let parentVC = parent as! PlayerDetailsViewController
        viewModel.fetchPlayerCareerInfo(id: parentVC.id)
        setupBinders()
        
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
    
    func setupBinders() {
        viewModel.$loadStatus.sink {[weak self] status in
            guard let self = self else {
                return
            }
            if (status == .finished) {
                dump(self.viewModel.careerData)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.store(in: &cancellables)
    }

}

extension PlayerDetailsCareerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CareerCollectionViewCell.identifier, for: indexPath) as! CareerCollectionViewCell
        let model = viewModel.careerData[indexPath.row]
        if (segmentControl.selectedSegmentIndex == 0) {
            cell.setCellDataFrom(model: model)
            return cell
        } else {
            cell.setCellDataFrom(model: model,isBowling: true)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("YEEET \(viewModel.careerData.count)")
        return viewModel.careerData.count
    }
    
    
}
