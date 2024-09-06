//
//  HomeView-ViewModel.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import Foundation
import SwiftData

extension HomeView {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        
        func addDelivery() {
            let newDelivery = Delivery(
                id: "5dd5f3a7156bae72fa5a5d6c",
                remarks: "Minim veniam minim nisi ullamco consequat anim reprehenderit laboris aliquip voluptate sit.",
                pickupTime: "2014-10-06T10:45:38-08:00".convertToDate()!,
                goodsPicture: URL(string: "https://loremflickr.com/320/240/cat?lock=9953")!,
                deliveryFee: "$92.14",
                surcharge: "136.46",
                route: Route(
                    start: "Noble Street",
                    end: "Montauk Court"
                ),
                sender: Sender(
                    phone: "+1 (899) 523-3905",
                    name: "Harding Welch",
                    email: "hardingwelch@comdom.com"
                ),
                isFavourite: false
            )
            self.modelContext.insert(newDelivery)
        }
        
        func deleteAllDeliveries() {
            do {
                try self.modelContext.delete(model: Delivery.self)
            } catch {
                print("Delete Delivery Fail: \(error.localizedDescription)")
            }
        }
        
        func fetchDeliveriesFromServer() {
            
        }
        
    }
    
}
