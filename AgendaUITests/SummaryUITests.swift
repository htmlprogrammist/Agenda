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
    
    /**
     We test setting up view of View: the only thing there is table view, so we check that it exists
     */
    func testSummaryViewSetup() {
        let tableView = app.tables["summaryTableView"]
        XCTAssertTrue(tableView.exists)
    }
    
    /**
     We tap on a random `UITableView` cell and one of charts will be opened. We check that there is no `summaryTableView` onto the screen and that there is chart and labels
     */
    func testOpeningChartsModule() {
        let tableView = app.tables["summaryTableView"]
        XCTAssertTrue(tableView.exists)
        tableView.cells.firstMatch.tap()
        
        let chartView = app.otherElements["barChartView"]
        let descriptionLabel = app.staticTexts["chartsDescriptionLabel"]
        let moreLessLabel = app.staticTexts["chartsMoreLessLabel"]
        
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: chartView)
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(chartView.exists)
        XCTAssertTrue(descriptionLabel.exists)
        XCTAssertTrue(moreLessLabel.exists)
    }
}
