//
//  MatchesViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit

class MatchesViewController: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dummyData: FixtureDetailsModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(segmentedControl.numberOfSegments)
        segmentedControl.defaultConfiguration(font: UIFont.systemFont(ofSize: 10), color: .red)
        segmentedControl.selectedConfiguration(font: UIFont.systemFont(ofSize: 17), color: .white)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: 210)
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: FixturesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FixturesCollectionViewCell.identifier)
        
        Service.shared.getFixtureById(id: 46199) {[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.dummyData = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)

    }
}

extension MatchesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixturesCollectionViewCell.identifier, for: indexPath) as! FixturesCollectionViewCell
        guard let model = dummyData else { return cell }
        cell.setup(model: FixtureCellModel(isLive: false, localTeamCode: model.runs?[0].team?.code ?? "N/A", visitorTeamCode: model.runs?[1].team?.code ?? "N/A", localTeamRun: model.runs?[0].score?.description ?? "N/A", visitorTeamRun: model.runs?[1].score?.description ?? "N/A", localTeamWicket: model.runs?[0].wickets?.description ?? "N/A", visitorTeamWicket: model.runs?[1].wickets?.description ?? "N/A", localTeamOver: model.runs?[0].overs?.description ?? "N/A", visitorTeamOver: model.runs?[1].overs?.description ?? "N/A", matchNote: model.note ?? "N/A", matchType: model.type ?? "N/A", localTeamImageUrl: model.runs?[0].team?.imagePath ?? "N/A", visitorTeamImageUrl: model.runs?[1].team?.imagePath ?? "N/A"))
        return cell
    }
    
    
}
