//
//  UIFunctions.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit


class UIFunctions {
    
    private init() {}
    
    static func setViewCornerRadius(view: UIView, cornerRadius: Double, edgeType: CACornerMask) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        view.layer.maskedCorners = edgeType
    }
}
