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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(Routes.getViewControllerBy(routeMap: .homeViewController), animated: true)
        }
    }
    
    

}
