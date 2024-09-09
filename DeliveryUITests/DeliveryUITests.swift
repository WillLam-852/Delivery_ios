//
//  DeliveryUITests.swift
//  DeliveryUITests
//
//  Created by Lam Wun Yin on 6/9/2024.
//

import XCTest

final class DeliveryUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFavouriteButtonToggle() throws {
        let app = XCUIApplication()
        
        // Assuming the FavouriteButton is on the first screen
        let favouriteButton = app.buttons["heart"] // Identifier for the button
        
        // Tap the button to toggle
        XCTAssertTrue(favouriteButton.exists)
        favouriteButton.tap()
        
        // Check if the state changed
        let filledHeartButton = app.buttons["heart.fill"]
        XCTAssertTrue(filledHeartButton.exists)
        
        // Toggle back
        filledHeartButton.tap()
        XCTAssertTrue(favouriteButton.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
