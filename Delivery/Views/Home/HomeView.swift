//
//  HomeView.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var deliveries: [Delivery]
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(deliveries.indices, id: \.self) { index in
                        NavigationLink(destination: DeliveryDetailView(delivery: deliveries[index])) {
                            DeliveryRow(delivery: deliveries[index])
                                .onAppear {
                                    if index == deliveries.count - 1 {
                                        viewModel.fetchDeliveriesFromServer()
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
                self.viewModel.addDelivery()
            }) {
                Image(systemName: "ellipsis.circle")
            })
        } detail: {
            Text("Select a Delivery")
        }
        .onAppear {
            if deliveries.isEmpty {
                viewModel.fetchDeliveriesFromServer()
            }
        }
    }
    
    
    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}
