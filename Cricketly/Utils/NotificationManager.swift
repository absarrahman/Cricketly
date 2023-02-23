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
    
    static func addNotification(title: String, subtitle: String, targetNotificationTime: String) {
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
        let timeInterval = time.timeIntervalSince(Date())
        print(timeInterval)
        if (timeInterval > 0) {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            // add our notification request
            userNotificationCenter.add(request)
        }
    }
    
    static func getAllPendingNotification(completion: @escaping([NotificationModel]) -> ()) {
        userNotificationCenter.getPendingNotificationRequests { requests in
            var pendingNotificationList: [NotificationModel] = []
            for request in requests {
                //                print("Title: \(request.content.title)")
                //                print("Body: \(request.content.body)")
                //                print("Date: \(request.trigger?.nextTriggerDate() ?? Date())")
                //                print("Identifier: \(request.identifier)")
                //                print("---------------")
                //reques
                guard  let trigger = request.trigger as? UNCalendarNotificationTrigger,
                       let triggerDate = trigger.nextTriggerDate()  else { continue }

                let notificationModel = NotificationModel(id: request.identifier, title: request.content.title, subtitle: request.content.subtitle, triggerDate: "\(CommonFunctions.getFormattedDateAndTime(date: triggerDate).date) \(CommonFunctions.getFormattedDateAndTime(date: triggerDate).time)")
                pendingNotificationList.append(notificationModel)
            }
            completion(pendingNotificationList)
        }
    }
}

