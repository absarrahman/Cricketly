//
//  DoubleExtension.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 22/2/23.
//

import Foundation

extension Double {
    
    func rounded(decimalPoint: Int) -> Double {
        let power = pow(10, Double(decimalPoint))
       return (self * power).rounded() / power
    }
}
