//
//  DeliveryAPIResponse.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import Foundation

struct DeliveryAPIResponse: Codable {
    let id: String
    let remarks: String
    let pickupTime: String
    let goodsPicture: String
    let deliveryFee: String
    let surcharge: String
    let route: Route
    let sender: Sender
    
    func convertToDelivery() -> Delivery {
        return Delivery(
            id: self.id,
            remarks: self.remarks,
            pickupTime: self.pickupTime.convertToDate()!,
            goodsPicture: URL(string: goodsPicture)!,
            deliveryFee: self.deliveryFee,
            surcharge: self.surcharge,
            route: self.route,
            sender: self.sender,
            isFavourite: false
        )
    }
}
