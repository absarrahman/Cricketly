//
//  Routes.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit


enum RouteMap{
    case initialViewController, tabBarViewController, matchDetailsViewController, browsePlayersViewController, playerDetailsViewController, teamsViewController
}

class Routes {
    
    //    private static let routes:[RouteMap: UIViewController] = [
    //
    //    ]
    
    private init() {}
    
    static func getViewControllerBy(routeMap:RouteMap) -> UIViewController {
        //        .initialViewController: InitialViewController(),
        //        .tabBarViewController: TabbarController(),
        //        .matchDetailsViewController: MatchDetailsViewController()
        let vc: UIViewController
        switch routeMap {
        case .initialViewController:
            vc = InitialViewController()
        case .tabBarViewController:
            vc = TabbarController()
        case .matchDetailsViewController:
            vc = MatchDetailsViewController()
        case .browsePlayersViewController:
            vc = BrowsePlayerViewController()
        case .playerDetailsViewController:
            vc = PlayerDetailsViewController()
        case .teamsViewController:
            vc = TeamsViewController()
        }
        
        
        return vc
    }
}
