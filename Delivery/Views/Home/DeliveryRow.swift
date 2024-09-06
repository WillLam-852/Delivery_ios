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
            GoodsPictureAsyncImage(url: delivery.goodsPicture)
            .frame(width: 100, height: 100)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("From:")
                        .font(.subheadline)
                    Text("To:")
                        .font(.subheadline)
                }
                VStack(alignment: .leading) {
                    Text(delivery.route.start)
                        .font(.headline)
                    Text(delivery.route.end)
                        .font(.headline)
                }

            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 10.0) {
                FavouriteButton(
                    isFavourite: $delivery.isFavourite,
                    isInteractive: false
                )
                
                if let totalFee = delivery.totalFee {
                    Text(totalFee)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    let delivery = Delivery(
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
        isFavourite: true
    )
    return DeliveryRow(delivery: delivery)
}
