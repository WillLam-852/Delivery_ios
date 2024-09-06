//
//  DeliveryDetailView-ViewModel.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import Foundation
import SwiftData

extension DeliveryDetailView {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
    }
    
}
