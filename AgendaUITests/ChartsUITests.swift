//
//  ChartsUITests.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 06.07.2022.
//

import XCTest

class ChartsUITests: XCTestCase {
    
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
    
    /**
     In this test we check that everything is correctly displayed on the screen.
     
     We open _Summary_ module, then tap the first cell and this opens _Charts_ module
     */
    func testChartsViewModule() throws {
        let tableView = app.tables["summaryTableView"]
        XCTAssertTrue(tableView.exists)
        tableView.cells.firstMatch.tap()
        
        let chartView = app.otherElements["barChartView"]
        let descriptionLabel = app.staticTexts["chartsDescriptionLabel"]
        let moreLessLabel = app.staticTexts["chartsMoreLessLabel"]
        
        XCTAssertTrue(chartView.exists)
        XCTAssertTrue(descriptionLabel.exists)
        XCTAssertTrue(moreLessLabel.exists)
    }
}
