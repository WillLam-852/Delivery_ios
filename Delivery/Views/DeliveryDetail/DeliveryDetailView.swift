//
//  DeliveryDetailView.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import SwiftUI
import SwiftData

struct DeliveryDetailView: View {
    @ObservedObject var delivery: Delivery
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("From:")
                        Text("To:")
                        Text("Time:")
                        Text("ID:")
                    }
                    VStack(alignment: .leading) {
                        Text(delivery.route.start)
                            .font(.headline)
                        Text(delivery.route.end)
                            .font(.headline)
                        Text(delivery.pickupTime, format: Date.FormatStyle(date: .numeric, time: .standard))
                            .font(.headline)
                        Text(delivery.id)
                            .font(.headline)
                    }
                    Spacer()
                    FavouriteButton(
                        isFavourite: $delivery.isFavourite,
                        isInteractive: true
                    )
                }
                
                Divider()
                
                Text("Goods to deliver")
                    .font(.title)
                GoodsPictureAsyncImage(url: delivery.goodsPicture)
                
                Divider()
                
                HStack {
                    Text("Delivery Fee")
                        .font(.title)
                    Spacer()
                    if let totalFee = delivery.totalFee {
                        Text(totalFee)
                            .font(.headline)
                    }
                }
                
                Divider()
                
                Text("Remarks")
                    .font(.title)
                Text(delivery.remarks)
                
                Divider()
                
                Text("Sender")
                    .font(.title)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name:")
                        Text("Email:")
                        Text("Phone:")
                    }
                    VStack(alignment: .leading) {
                        Text(delivery.sender.name)
                            .font(.headline)
                        Text(delivery.sender.email)
                            .font(.headline)
                        Text(delivery.sender.phone)
                            .font(.headline)
                    }
                }
                
            }
            .padding()
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
        isFavourite: false
    )
    return DeliveryDetailView(delivery: delivery)
}
