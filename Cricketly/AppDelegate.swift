//
//  AppDelegate.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let initialVC = InitialViewController()
        let navigationController = UINavigationController(rootViewController: initialVC)
        window?.rootViewController = navigationController
        return true
    }

}

