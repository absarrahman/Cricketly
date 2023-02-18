//
//  InitialViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
        //            guard let self = self else { return }
        //            self.navigationController?.pushViewController(Routes.getViewControllerBy(routeMap: .tabBarViewController), animated: true)
        //        }
        
        Service.shared.getAllPlayers { result in
            switch result {
            case .success(let success):
                print(success?.first?.fullname)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.pushViewController(Routes.getViewControllerBy(routeMap: .tabBarViewController), animated: true)
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.viewControllers.removeAll(where: {
            $0 == self
        })
    }
    
    
    
}
