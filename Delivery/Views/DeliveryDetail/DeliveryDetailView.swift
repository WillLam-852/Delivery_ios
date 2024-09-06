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
                        Text("From: \(delivery.route.start)")
                        Text("To: \(delivery.route.end)")
                        Text("Time: \(delivery.pickupTime, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        Text("ID: \(delivery.id)")
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
                
                Divider()
                
                HStack {
                    Text("Delivery Fee")
                        .font(.title)
                    Spacer()
                    Text(delivery.deliveryFee)
                    Text(delivery.surcharge)
                }
                
                Divider()
                
                Text("Remarks")
                    .font(.title)
                Text(delivery.remarks)
                
                Divider()
                
                Text("Sender")
                    .font(.title)
                Text(delivery.sender.name)
                Text(delivery.sender.email)
                Text(delivery.sender.phone)
                
                
            }
            .padding()
        }
    }
    
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Delivery.self, configurations: config)
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
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
