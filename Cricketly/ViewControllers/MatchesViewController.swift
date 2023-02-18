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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
        for i in 0..<selectedList.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixturesCollectionViewCell.identifier, for: indexPath) as! FixturesCollectionViewCell
            cell.endTimer()
        }
        selectedList = []
        collectionView.reloadData()
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
        let selectedFixtureID = selectedList[indexPath.row].id
        let vc = Routes.getViewControllerBy(routeMap: .matchDetailsViewController) as! MatchDetailsViewController
        vc.selectedFixtureId = selectedFixtureID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.2, delay: 0.07 * Double(indexPath.row) / 3.5, options: [.curveEaseInOut]) {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let customCell = cell as? FixturesCollectionViewCell {
            if segmentedControl.selectedSegmentIndex == segmentedControl.numberOfSegments - 1 {
                customCell.endTimer()
            }
        }
    }
}
