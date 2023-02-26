//
//  DateFixtureViewController.swift
//  Cricketly
//
//  Created by BJIT  on 26/2/23.
//

import UIKit
import Combine

class DateFixtureViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var startDate: UIDatePicker!
    
    
    @IBOutlet weak var endDate: UIDatePicker!
    
    
    let viewModel = DateFixtureModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        startDate.minimumDate = Date.now
        endDate.minimumDate = (Date.now.addingTimeInterval(15*24*60*60))
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width * 0.95, height: 177)
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        collectionView.register(UINib(nibName: FixturesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FixturesCollectionViewCell.identifier)
        viewModel.fetchFixtureData(startDate: startDate.date, endDate: endDate.date)
        setupBinders()
    }
    
    func setupBinders() {
        viewModel.$loadingStatus.sink {[weak self] loadingStatus in
            
            guard let self = self else {
                return
            }
            
            if (loadingStatus == .finished) {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.store(in: &cancellables)
    }
    
    @IBAction func findMatchTapped(_ sender: UIButton) {
        viewModel.fetchFixtureData(startDate: startDate.date, endDate: endDate.date)
    }
    
}

extension DateFixtureViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.fixtureDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixturesCollectionViewCell.identifier, for: indexPath) as! FixturesCollectionViewCell
        let model = viewModel.fixtureDataList[indexPath.row]
        cell.setup(model: model)
        return cell
    }
    
    
    
}
