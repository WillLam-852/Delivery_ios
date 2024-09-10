//
//  HomeView.swift
//  Delivery
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(self.viewModel.displayedDeliveriesForThisPage.indices, id: \.self) { index in
                        if index < self.viewModel.displayedDeliveriesForThisPage.count {
                            NavigationLink(destination: DeliveryDetailView(delivery: self.viewModel.displayedDeliveriesForThisPage[index])) {
                                DeliveryRow(delivery: self.viewModel.displayedDeliveriesForThisPage[index])
                                    .onAppear {
                                        if index == self.viewModel.displayedDeliveriesForThisPage.count - 1 {
                                            self.viewModel.fetchDeliveriesFromServer()
                                        }
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                            Divider()
                        }
                        
                    }
                }
                .padding()
            }
            .navigationTitle("My Deliveries")
            HStack {
                Spacer()
                Button(action: {
                    self.viewModel.decreasePage()
                }, label: {
                    Image(systemName: "chevron.left")
                })
                .disabled(self.viewModel.page == 1)
                .accessibilityIdentifier("previous_page")
                
                Spacer()
                Text("Page :   \(self.viewModel.page) / \(self.viewModel.totalPage)")
                Spacer()
                
                Button(action: {
                    self.viewModel.increasePage()                      
                }, label: {
                    Image(systemName: "chevron.right")
                })
                .disabled(self.viewModel.page == self.viewModel.totalPage)
                .accessibilityIdentifier("next_page")
                Spacer()
                
                Button(action: {
                    self.viewModel.deleteAllDeliveries()
                }, label: {
                    Text("Delete")
                })
            }
            .padding(.top)
        } detail: {
            Text("Select a Delivery")
        }
        .onAppear {
            self.viewModel.fetchDeliveriesFromServer()
        }
    }
            
    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}


#Preview {
    let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Delivery.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    return HomeView(modelContext: sharedModelContainer.mainContext)
        .modelContainer(for: Delivery.self, inMemory: true)
}
