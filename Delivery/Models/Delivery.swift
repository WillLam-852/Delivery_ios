//
//  Delivery.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import Foundation
import SwiftData

@Model
final class Delivery {
    var id: String
    var remarks: String
    var pickupTime: Date
    var goodsPicture: URL
    var deliveryFee: String
    var surcharge: String
    var totalFee: String? {
        get {
            if let deliveryFeeDouble = self.deliveryFee.convertToDouble(),
               let surchargeDouble = self.surcharge.convertToDouble() {
                return "$\(deliveryFeeDouble + surchargeDouble)"
            }
            return nil
        }
    }
    var route: Route
    var sender: Sender
    var isFavourite: Bool
    
    init(id: String, remarks: String, pickupTime: Date, goodsPicture: URL, deliveryFee: String, surcharge: String, route: Route, sender: Sender, isFavourite: Bool = false) {
        self.id = id
        self.remarks = remarks
        self.pickupTime = pickupTime
        self.goodsPicture = goodsPicture
        self.deliveryFee = deliveryFee
        self.surcharge = surcharge
        self.route = route
        self.sender = sender
        self.isFavourite = isFavourite
    }
}

struct Route: Codable {
    let start: String
    let end: String
}

struct Sender: Codable {
    let phone: String
    let name: String
    let email: String
}
