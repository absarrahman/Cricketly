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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let parentVC = parent as! PlayerDetailsViewController
        viewModel.fetchPlayerCareerInfo(id: parentVC.id)
        setupBinders()
        
    }
    
    func setupBinders() {
        viewModel.$loadStatus.sink {[weak self] status in
            guard let self = self else {
                return
            }
            if (status == .finished) {
                dump(self.viewModel.careerData)
            }
        }.store(in: &cancellables)
    }

}
