//
//  HomeViewModelTests.swift
//  DeliveryTests
//
//  Created by Lam Wun Yin on 8/9/2024.
//

import XCTest
import SwiftData
@testable import Delivery

final class HomeViewModelTests: XCTestCase {
        
    var viewModel: HomeView.ViewModel!
    var mockModelContext: ModelContext!
    
    let mockDelivery = Delivery(
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
    
    @MainActor override func setUp() {
        super.setUp()
        let mockModelContainer: ModelContainer = {
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
        self.mockModelContext = mockModelContainer.mainContext
        self.viewModel = HomeView.ViewModel(modelContext: self.mockModelContext)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.mockModelContext = nil
        super.tearDown()
    }
    
    func testFetchDeliveriesFromLocal() {
        self.viewModel.fetchDeliveriesFromLocal()
        XCTAssertEqual(self.viewModel.deliveries.count, try self.mockModelContext.fetchCount(FetchDescriptor<Delivery>()))
    }
    
    func testPaginationLogic() {
        self.viewModel.deliveries = Array(repeating: self.mockDelivery, count: 45) // Mock deliveries
        XCTAssertEqual(viewModel.totalPage, 3)
        
        self.viewModel.page = 1
        XCTAssertEqual(viewModel.displayedDeliveriesForThisPage.count, 20)
        
        self.viewModel.page = 3
        XCTAssertEqual(viewModel.displayedDeliveriesForThisPage.count, 5)
    }
    
    func testIncreasePage() {
        self.viewModel.page = 1
        self.viewModel.increasePage()
        XCTAssertEqual(viewModel.page, 2)
    }
    
    func testDecreasePage() {
        self.viewModel.page = 2
        self.viewModel.decreasePage()
        XCTAssertEqual(self.viewModel.page, 1)
    }
    
}
