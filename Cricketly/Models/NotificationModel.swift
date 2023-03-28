//
//  NotificationModel.swift
//  Cricketly
//
//  Created by BJIT  on 23/2/23.
//

import Foundation
// let notificationModel = NotificationModel(id: request.identifier, title: request.content.title, subtitle: request.content.subtitle, triggerDate: "\(CommonFunctions.getFormattedDateAndTime(date: triggerDate).date) \(CommonFunctions.getFormattedDateAndTime(date: triggerDate).time)")
struct NotificationModel {
    let id: String
    let title: String
    let subtitle: String
    let triggerDate: String
}
