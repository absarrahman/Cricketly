//
//  AppDelegate.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NotificationManager.userNotificationCenter.delegate = self
        NotificationManager.getNotificationPermission { granted in
            if (granted) {
                // SUCCESS
            } else {
                // NOT DONE
                
            }
            print(granted)
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let initialVC = InitialViewController()
        let navigationController = UINavigationController(rootViewController: initialVC)
        window?.rootViewController = navigationController
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.banner,.list,.sound])
    }

}

