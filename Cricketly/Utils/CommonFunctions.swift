//
//  CommonFunctions.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

class CommonFunctions {
    
    static let dateComponentFormatter: DateComponentsFormatter = {
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.allowedUnits = [.day, .hour, .minute, .second]
        componentsFormatter.maximumUnitCount = 7
        componentsFormatter.unitsStyle = .full
        componentsFormatter.zeroFormattingBehavior = .default
        return componentsFormatter
    }()
    
    static func getDifference(from timeString: String) -> DateComponents? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let time = formatter.date(from: timeString) else { return nil }
        
        
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: time)
        
        return difference
    }
    
    static var getWindowSafeAreaInsets: UIEdgeInsets? {
        get {
            let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return window?.safeAreaInsets
        }
    }
}
