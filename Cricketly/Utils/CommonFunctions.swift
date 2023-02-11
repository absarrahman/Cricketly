//
//  CommonFunctions.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

class CommonFunctions {
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
