//
//  TabbarController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit

class TabbarController: UITabBarController {
    
    private let vcFactory = ViewControllerFactory()
    
    fileprivate func setupTabBarLayout() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: self.tabBar.bounds.minY, width: self.tabBar.bounds.width - 60, height: self.tabBar.bounds.height + 10), cornerRadius: (self.tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        print(view.frame.height)
        //let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        //view.frame.height > 667 ? 0 : 50
        var bottomPadding = CommonFunctions.getWindowSafeAreaInsets?.bottom ?? 50
        
        print(bottomPadding)
        
        bottomPadding = bottomPadding > 0 ? 0 : 50
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomPadding, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UITabBar.appearance().tintColor = .systemRed
        self.viewControllers = [createHomeVC(), createMatchVC()]
        setupTabBarLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func createHomeVC() -> UIViewController {
        let homeVC = vcFactory.createVC(vcType: .homeVC)
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return homeVC
    }
    
    func createMatchVC() -> UIViewController {
        let matchVC = vcFactory.createVC(vcType: .matchVC)
        matchVC.title = "Matches"
        matchVC.tabBarItem = UITabBarItem(title: "Matches", image: UIImage(systemName: "cricket.ball.fill"), tag: 0)
        
        return matchVC
    }
    
}
