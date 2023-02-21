//
//  MatchDetailsViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import UIKit
import SDWebImage
import Combine


enum SectionTabs: String, CaseIterable {
    case info, scoreboard, squad
}

class MatchDetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    let viewModel = MatchDetailsViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    var selectedFixtureId: Int?
    
    var selectedTab: SectionTabs = .info
    
    var selectedVC: UIViewController!
    
    var matchStatus: Status = .ns
    
    var sectionsMap: [SectionTabs:UIViewController] = [
        .info: MatchInfoViewController(),
        .scoreboard: MatchScoreViewController(),
        .squad: MatchSquadViewController()
    ]
    
    fileprivate func addChildVC(_ vc: UIViewController) {
        selectedVC = vc
        setContainerViewController(containerViewController: vc, containerView: containerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 20
        collectionView.clipsToBounds = true
        collectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        // TODO: Keep all container vc in one list
        let vc = sectionsMap[.info]!
        addChildVC(vc)
        collectionView.register(UINib(nibName: MatchDetailsSectionLabelCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MatchDetailsSectionLabelCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.fetchMatchStatusBy(id: selectedFixtureId ?? -1)
        
    }
    
    func setupBinders()  {
        view.isUserInteractionEnabled = false
        viewModel.$loadingStatus.sink {[weak self] status in
            
            guard let self = self else { return }
            
            if status == .finished {
                self.matchStatus = self.viewModel.matchStatus
                self.view.isUserInteractionEnabled = true
            }
            
        }.store(in: &cancellables)
    }
}

extension MatchDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        SectionTabs.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchDetailsSectionLabelCollectionViewCell.identifier, for: indexPath) as! MatchDetailsSectionLabelCollectionViewCell
        
        let currentSection = SectionTabs.allCases[indexPath.row]
        
        let model = MatchDetailsSectionCollectionCellModel(sectionTitle: currentSection.rawValue.capitalized, isSelected: currentSection == selectedTab)
        
        cell.setupCellModel(model: model)
        
        return cell
    }
    
}

extension MatchDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTab = SectionTabs.allCases[indexPath.row]
        remove(asChildViewController: selectedVC)
        if (selectedTab == .squad && matchStatus == .ns) {
            addChildVC(MatchSquadNotFoundViewController())
        } else {
            addChildVC(sectionsMap[selectedTab]!)
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1, delay: 0.07 * Double(indexPath.row) / 3.5, options: [.curveEaseInOut], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}
