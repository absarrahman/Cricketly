//
//  BrowsePlayerViewController.swift
//  Cricketly
//
//  Created by BJIT  on 18/2/23.
//

import UIKit

class BrowsePlayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
}
