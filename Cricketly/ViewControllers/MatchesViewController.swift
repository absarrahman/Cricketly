//
//  MatchesViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit
import Combine

class MatchesViewController: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dummyData: FixtureDetailsModel?
    
    let viewModel = MatchesViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    
    var selectedList: [FixtureCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(segmentedControl.numberOfSegments)
        segmentedControl.defaultConfiguration(font: UIFont.systemFont(ofSize: 10), color: .red)
        segmentedControl.selectedConfiguration(font: UIFont.systemFont(ofSize: 17), color: .white)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width * 0.95, height: 177)
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: FixturesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FixturesCollectionViewCell.identifier)
        setupBinders()
        viewModel.fetchFixtureData(for: FixtureType(rawValue: segmentedControl.selectedSegmentIndex) ?? .recent)
    }
    
    func setupBinders() {
        viewModel.$error.sink { error in
            guard let error = error else {
                return
            }
            print("ERROR OCCURRED \(error)")
        }.store(in: &cancellables)
        
        viewModel.$fixtureDataList.sink {[weak self] fixtureModels in
            guard let self = self else { return }
            self.selectedList = fixtureModels
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        viewModel.fetchFixtureData(for: FixtureType(rawValue: sender.selectedSegmentIndex) ?? .live)
    }
}

extension MatchesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixturesCollectionViewCell.identifier, for: indexPath) as! FixturesCollectionViewCell
        let model = selectedList[indexPath.row]
        cell.setup(model: model)
        return cell
    }
    
    
}

extension MatchesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Routes.getViewControllerBy(routeMap: .matchDetailsViewController)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true

            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
    }
}