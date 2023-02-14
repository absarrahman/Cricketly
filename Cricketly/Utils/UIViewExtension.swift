//
//  UIViewExtension.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 15/2/23.
//

import UIKit

extension UIViewController {
    func setContainerViewController(containerViewController: UIViewController,
                                    containerView: UIView) {
        addChild(containerViewController)
        containerViewController.view.frame = containerView.bounds
        containerView.addSubview(containerViewController.view)
        containerViewController.didMove(toParent: self)
    }
}
