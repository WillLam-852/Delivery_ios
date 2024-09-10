//
//  HomeView-ViewModel.swift
//  Delivery
//
//  Created by Lam Wun Yin on 9/9/2024.
//

import SwiftUI
import SwiftData

extension HomeView {
    
    class ViewModel: ObservableObject {
        
            // MARK: - Variables
        
        var modelContext: ModelContext
        
            /// All Delivery items in the local storage
        @Published var deliveries: [Delivery] = []
            /// Displayed Delivery items for this page
        var displayedDeliveriesForThisPage: [Delivery] {
            let firstIndex = (self.page - 1) * self.maxItemPerPage
            if self.page != self.totalPage {
                let lastIndex = self.page * self.maxItemPerPage
                let slice = self.deliveries[firstIndex..<lastIndex]
                return Array(slice)
            } else {
                let slice = self.deliveries[firstIndex...]
                return Array(slice)
            }
        }
        
            /// Pagination for HomeView (Start from 1)
        @Published var page = 1

            /// Query string parameter for fetching deliveries from server
        private var offset = 0
            /// Maximum item per page
        private let maxItemPerPage = 20
            /// Indicator for fetching data from server
        private var isFetching = false
            /// Total number of pages
        var totalPage: Int {
            get {
                (self.deliveries.count - 1) / self.maxItemPerPage + 1
            }
        }
        
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            self.fetchDeliveriesFromLocal()
        }
        
        
            // MARK: - Methods
        
        func fetchDeliveriesFromLocal() {
            DispatchQueue.main.async {
                do {
                    let descriptor = FetchDescriptor<Delivery>()
                    self.deliveries = try self.modelContext.fetch(descriptor)
                } catch {
                    print("Fetch failed")
                }
            }
        }
        
        
        func fetchDeliveriesFromServer() {
            guard !self.isFetching && self.page == self.totalPage else { return }
            self.isFetching = true
            
            var urlComponents = URLComponents(string: K.serverAddress)
            urlComponents?.queryItems = [
                URLQueryItem(name: "offset", value: String(self.offset))
            ]
            
            if let finalURL = urlComponents?.url {
                URLSession.shared.dataTask(with: finalURL) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        do {
                            let deliveryResponses = try JSONDecoder().decode([DeliveryAPIResponse].self, from: data)
                            let newDeliveries = deliveryResponses.map { $0.convertToDelivery() }
                            for newDelivery in newDeliveries {
                                self.modelContext.insert(newDelivery)
                            }
                            self.isFetching = false
                            self.offset += 1
                            self.fetchDeliveriesFromLocal()
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                        }
                    }
                }.resume()
            } else {
                print("Error creating the final URL")
            }
        }
        
        
        func increasePage() {
            DispatchQueue.main.async {
                self.page += 1
            }
        }
        
        
        func decreasePage() {
            DispatchQueue.main.async {
                self.page -= 1
            }
        }
        
    }

    
}
