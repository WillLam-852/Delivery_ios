//
//  HomeView.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var deliveries: [Delivery]
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(deliveries.indices, id: \.self) { index in
//                        NavigationLink(destination: DeliveryDetailView(delivery: viewModel.deliveries[index])) {
                            DeliveryRow(delivery: deliveries[index])
                                .onAppear {
                                    if index == deliveries.count - 1 {
//                                        viewModel.fetchDeliveriesFromServer()
                                    }
                                }
//                        }
                        .buttonStyle(PlainButtonStyle())
                        Divider()
                    }
                }
                .padding()
            }
            .navigationTitle("My Deliveries")
            .onAppear {
//                viewModel.fetchDeliveries()
            }
            .navigationBarItems(trailing:
                                    Button(action: {
//                viewModel.fetchDeliveriesFromServer()
                self.addDelivery()
            }) {
                Image(systemName: "ellipsis.circle")
            })
        } detail: {
            Text("Select a Delivery")
        }
        .onAppear {
            if deliveries.isEmpty {
//                viewModel.fetchDeliveriesFromServer()
            }
        }
    }
    
    private func addDelivery() {
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
}

#Preview {
    HomeView()
        .modelContainer(for: Delivery.self, inMemory: true)
}
