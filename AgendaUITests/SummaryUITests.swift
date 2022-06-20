//
//  SummaryUITests.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 18.06.2022.
//

import XCTest

class SummaryUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let device = XCUIDevice.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
        /// Opening Summary module in  tab bar
        app.tabBars.buttons.element(boundBy: 2).tap()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    
    func testSummaryViewSetup() {
        let tableView = app.tables["summaryTableView"]
        XCTAssertTrue(tableView.exists)
    }
}
