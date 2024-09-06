//
//  String.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self)
    }
    
    
    func convertToDouble() -> Double? {
            // Remove the "$" sign from the string
        let stringWithoutDollarSign = String(self.dropFirst())
        
            // Convert the modified string to a double
        return Double(stringWithoutDollarSign)
    }
    
}
