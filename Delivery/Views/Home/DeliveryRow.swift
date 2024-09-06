//
//  DeliveryRow.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import SwiftUI

struct DeliveryRow: View {
    @ObservedObject var delivery: Delivery
    
    var body: some View {
        HStack {
            AsyncImage(url: delivery.goodsPicture) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                }
            }
            .frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
                Text("From: \(delivery.route.start)")
                Text("To: \(delivery.route.end)")
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 10.0) {
                FavouriteButton(
                    isFavourite: $delivery.isFavourite,
                    isInteractive: false
                )
                
                if let totalFee = delivery.totalFee {
                    Text(totalFee)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

//#Preview {
//    Group {
//        DeliveryRow(delivery: testDeliveries[0])
//        DeliveryRow(delivery: testDeliveries[1])
//    }
//}
