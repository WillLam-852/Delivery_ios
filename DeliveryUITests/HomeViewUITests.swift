//
//  HomeViewUITests.swift
//  DeliveryUITests
//
//  Created by Lam Wun Yin on 10/9/2024.
//

import XCTest

class HomeViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testNavigateThroughPages() throws {
        let previousPageButton = app.buttons["previous_page"]
        let nextPageButton = app.buttons["next_page"]
        
            // Verify initial state
        XCTAssertTrue(previousPageButton.exists)
        XCTAssertTrue(nextPageButton.exists)
        XCTAssertFalse(previousPageButton.isEnabled)
        XCTAssertFalse(nextPageButton.isEnabled)
    }
}
