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
    @State private var page = 0
    @State private var isFetching = false
    @State private var showFavoritesOnly = false
    
    var filteredDeliveries: [Delivery] {
        if showFavoritesOnly {
            return deliveries.filter { $0.isFavourite }
        } else {
            return deliveries
        }
    }
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredDeliveries.indices, id: \.self) { index in
                        NavigationLink(destination: DeliveryDetailView(delivery: filteredDeliveries[index])) {
                            DeliveryRow(delivery: filteredDeliveries[index])
                                .onAppear {
                                    if index == deliveries.count - 1 && !isFetching {
                                        page += 1
                                        fetchDeliveriesForPage(page)
                                    }
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                        Divider()
                    }
                }
                .padding()
            }
            .navigationTitle("My Deliveries")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showFavoritesOnly.toggle()
                }) {
                    Image(systemName: self.showFavoritesOnly ? "heart.fill" : "heart")
                }
            )
        } detail: {
            Text("Select a Delivery")
        }
        .onAppear {
            if deliveries.isEmpty {
                fetchDeliveriesForPage(page)
            }
        }
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
    
    func fetchDeliveriesFromServer(page: Int, pageSize: Int, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.addDelivery()
            completion()
        }
    }
    
    func fetchDeliveriesForPage(_ page: Int) {
        self.isFetching = true
        self.fetchDeliveriesFromServer(page: page, pageSize: 20) {
            self.isFetching = false
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Delivery.self, inMemory: true)
}
