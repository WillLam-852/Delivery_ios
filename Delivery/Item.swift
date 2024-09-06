//
//  Item.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
