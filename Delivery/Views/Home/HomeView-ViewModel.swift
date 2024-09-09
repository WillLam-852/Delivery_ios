//
//  HomeView-ViewModel.swift
//  Delivery
//
//  Created by Lam Wun Yin on 9/9/2024.
//

import SwiftUI
import SwiftData

extension HomeView {
    
    @Observable
    class ViewModel {
        
            // MARK: - Variables
        
        var modelContext: ModelContext
        
            /// All Delivery items in the local storage
        var deliveries: [Delivery] = []
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
            /// Query string parameter for fetching deliveries from server
        var offset = 0
            /// Pagination for HomeView (Start from 1)
        var page = 1
            /// Maximum item per page
        private let maxItemPerPage = 20
            /// Indicator for fetching data from server
        var isFetching = false
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
            do {
                let descriptor = FetchDescriptor<Delivery>()
                self.deliveries = try self.modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
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
                            self.deliveries.append(contentsOf: newDeliveries)
                            self.isFetching = false
                            self.offset += 1
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
            self.page += 1
        }
        
        
        func decreasePage() {
            self.page -= 1
        }
        
        
        // These 2 functions are for testing only
        
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
            self.fetchDeliveriesFromLocal()
        }
        
        
        func deleteAllDeliveries() {
            do {
                try self.modelContext.delete(model: Delivery.self)
                self.fetchDeliveriesFromLocal()
            } catch {
                print("Delete Delivery Fail: \(error.localizedDescription)")
            }
        }

    }

    
}
