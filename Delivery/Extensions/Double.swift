//
//  Double.swift
//  Delivery
//
//  Created by Lam Wun Yin on 9/9/2024.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
