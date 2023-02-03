//
//  Routes.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit


enum RouteMap{
    case initialViewController, homeViewController
}

class Routes {
    
    private static let routes:[RouteMap: UIViewController] = [
        .initialViewController: InitialViewController(),
        .homeViewController: HomeViewController()
    ]
    
    private init() {}
    
    static func getViewControllerBy(routeMap:RouteMap) -> UIViewController {
        
        guard let viewController = routes[routeMap] else { return UIViewController() }
        
        return viewController
    }
}
