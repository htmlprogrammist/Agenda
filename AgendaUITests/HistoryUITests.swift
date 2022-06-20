//
//  HistoryUITests.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 18.06.2022.
//

import XCTest

class HistoryUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let device = XCUIDevice.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
        /// Opening History module in  tab bar
        app.tabBars.buttons.element(boundBy: 1).tap()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    
    func testHistoryViewSetup() throws {
        let editButtonItem = app.navigationBars.firstMatch
        let tableView = app.tables.firstMatch
        let cell = tableView.cells.firstMatch
        
        XCTAssertTrue(editButtonItem.exists)
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(cell.exists)
        XCTAssertTrue(cell.isEnabled)
    }
    
    func testOpeningCurrentMonth() throws {
        let tableView = app.tables.firstMatch
        let cell = tableView.cells.firstMatch
        cell.tap()
        
        let agendaTableView = app.tables["tableView"]
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: agendaTableView)
        wait(for: [expectation], timeout: 5)
    }
    
    func testOpeningMonthDetailsModule() throws {
        let tableView = app.tables.firstMatch
        let cell = tableView.cells.element(boundBy: 1)
        cell.tap()
        
        let monthDetailsTableView = app.tables["tableView"]
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: monthDetailsTableView)
        wait(for: [expectation], timeout: 5)
    }
    
    func testOpeningAlertWithDeletingMonth() throws {
        let tableView = app.tables.firstMatch
        let cell = tableView.cells.element(boundBy: 1)
        cell.swipeLeft()
        
        addUIInterruptionMonitor(withDescription: "Delete month") { alert in
            alert.buttons.firstMatch.tap()
            return true
        }
        
        let deleteButton = cell.buttons.firstMatch
        deleteButton.tap()
        
    }
    
    func testOpeningAlertAndDeletingMonth() throws {
        let tableView = app.tables.firstMatch
        let cell = tableView.cells.element(boundBy: 1)
        cell.swipeLeft()
        let deleteButton = cell.buttons.firstMatch
        deleteButton.tap()
        
        addUIInterruptionMonitor(withDescription: "Delete month") { alert in
            alert.buttons.element(boundBy: 1).tap()
            return true
        }
    }
}
