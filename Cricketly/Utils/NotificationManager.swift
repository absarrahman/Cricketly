//
//  NotificationManager.swift
//  Cricketly
//
//  Created by BJIT  on 23/2/23.
//

import Foundation
import UserNotifications



class NotificationManager {
    static let userNotificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    static func getNotificationPermission(completion: @escaping(Bool)->()) {
        userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                print("All set!")
//
//            } else if let error = error {
//                print(error.localizedDescription)
//                completion(false)
//            }
            completion(success)
        }
    }
    
    static func checkNotificationExists(id: Int, completion: @escaping(Bool)->()) {
        userNotificationCenter.getPendingNotificationRequests { requests in
            for request in requests {
                if (request.identifier == id.description) {
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
    
    static func addNotification(id: Int, title: String, subtitle: String, targetNotificationTime: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let time = formatter.date(from: targetNotificationTime) else { return }
        let fifteenMinsBefore = time.addingTimeInterval(-15 * 60)
        let timeInterval = fifteenMinsBefore.timeIntervalSince(Date())
        print(timeInterval)
        if (timeInterval > 0) {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: id.description, content: content, trigger: trigger)
            
            // add our notification request
            userNotificationCenter.add(request)
        }
    }
    
    static func addNotificationNowNotify() {
        let content = UNMutableNotificationContent()
        content.title = "Notification added"
        content.subtitle = "You will be notified before 15 minutes"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.001, repeats: false)
        let id = UUID().uuidString
        let request = UNNotificationRequest(identifier: id.description, content: content, trigger: trigger)
        
        // add our notification request
        userNotificationCenter.add(request)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            userNotificationCenter.removeDeliveredNotifications(withIdentifiers: [id.description])
        }
    }
    
    static func getAllPendingNotification(completion: @escaping([NotificationModel]) -> ()) {
        userNotificationCenter.getPendingNotificationRequests { requests in
            var pendingNotificationList: [NotificationModel] = []
            for request in requests {
                var date = ""
                if let trigger = request.trigger as? UNTimeIntervalNotificationTrigger {
                    let triggerDate = Date(timeIntervalSinceNow: trigger.timeInterval)
                    date = "\(CommonFunctions.getFormattedDateAndTime(date: triggerDate).date) \(CommonFunctions.getFormattedDateAndTime(date: triggerDate).time)"
                    
                }
                
                let notificationModel = NotificationModel(id: request.identifier, title: request.content.title, subtitle: request.content.subtitle, triggerDate: date)
                pendingNotificationList.append(notificationModel)
            }
            completion(pendingNotificationList)
        }
    }
    
    static func getAllDeliveredNotification(completion: @escaping([NotificationModel]) -> ()) {
        userNotificationCenter.getDeliveredNotifications { requests in
            var deliveredNotificationList: [NotificationModel] = []
            for request in requests {
                let date = request.date
                
                let notificationModel = NotificationModel(id: request.request.identifier, title: request.request.content.title, subtitle: request.request.content.subtitle, triggerDate: "\(CommonFunctions.getFormattedDateAndTime(date: date).date) \(CommonFunctions.getFormattedDateAndTime(date: date).time)")
                deliveredNotificationList.append(notificationModel)
            }
            completion(deliveredNotificationList)
        }
    }
}

