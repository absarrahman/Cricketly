//
//  HomeViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var bannerView: UIView!
    
    
    @IBOutlet weak var bannerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var matchesLabelTopConstraint: NSLayoutConstraint!
    
    var lastContentOffset: CGFloat = 0
    
    var totalFixtureList: [FixtureCellModel] = []
    
    let viewModel = HomeViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        UIFunctions.setViewCornerRadius(view: bannerView, cornerRadius: 20, edgeType: [.layerMaxXMinYCorner,.layerMaxXMaxYCorner])
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width * 0.8, height: collectionView.bounds.height * 0.9)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: FixturesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FixturesCollectionViewCell.identifier)
        
        tableView.register(UINib(nibName: NewsTypeOneTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTypeOneTableViewCell.identifier)
        
        tableView.register(UINib(nibName: NewsTypeTwoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTypeTwoTableViewCell.identifier)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.fetchData()
        setupBinders()
    }
    
    fileprivate func setDataToList() {
        self.totalFixtureList = []
        self.totalFixtureList = self.viewModel.liveMatches + self.viewModel.upcomingMatches + self.viewModel.recentMatches
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupBinders() {
        viewModel.$upcomingLoadingStatus.sink { [weak self] loadStatus in
            guard let self = self else {
                return
            }
            if (loadStatus == .finished) {
                self.setDataToList()
            }
        }.store(in: &cancellables)
        
        viewModel.$liveLoadingStatus.sink {[weak self] loadStatus in
            
            guard let self = self else {
                return
            }
            if (loadStatus == .finished) {
                self.setDataToList()
            }
        }.store(in: &cancellables)
        
        viewModel.$isRecentLoaded.sink {[weak self] loadStatus in
            
            guard let self = self else {
                return
            }
            if (loadStatus == .finished) {
                self.setDataToList()
            }
        }.store(in: &cancellables)
        
        viewModel.$isNewsLoaded.sink {[weak self] loadStatus in
            
            guard let self = self else {
                return
            }
            if (loadStatus == .finished) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.store(in: &cancellables)
    }
    
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalFixtureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixturesCollectionViewCell.identifier, for: indexPath) as! FixturesCollectionViewCell
        let model = totalFixtureList[indexPath.row]
        cell.setup(model: model)
        return cell
    }
}


extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.newsList[indexPath.row]
        if (indexPath.row % 5 == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTypeOneTableViewCell.identifier, for: indexPath) as! NewsTypeOneTableViewCell
            
            cell.setNewsModel(model: model)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTypeTwoTableViewCell.identifier, for: indexPath) as! NewsTypeTwoTableViewCell
        
        cell.setNewsModel(model: model)
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, delay: 0) {[weak self] in
            guard let self = self else {
                return
            }
            if (100 > scrollView.contentOffset.y) {
                // Up
                
                self.matchesLabelTopConstraint.constant = 150
                self.bannerTopConstraint.constant = 40
                self.view.layoutIfNeeded()
                
            } else if (100 < scrollView.contentOffset.y) {
                // DOWN
                self.matchesLabelTopConstraint.constant = 0
                self.bannerTopConstraint.constant = -500
                self.view.layoutIfNeeded()
                
            }
        }
        
        //self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Routes.getViewControllerBy(routeMap: .webViewController) as! WKViewController
        let model = viewModel.newsList[indexPath.row]
        vc.urlString = model.url ?? ""
        present(vc, animated: true)
    }
}
