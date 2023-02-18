//
//  ViewControllerFactory.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 11/2/23.
//

import UIKit

enum ViewControllerForTabs {
    case homeVC, matchVC, moreVC
}

struct ViewControllerFactory {
    func createVC(vcType: ViewControllerForTabs) -> UIViewController {
        switch vcType {
        case .homeVC:
            return HomeViewController()
        case .matchVC:
            return MatchesViewController()
        case .moreVC:
            return MoreTabViewController()
        }
    }
}
