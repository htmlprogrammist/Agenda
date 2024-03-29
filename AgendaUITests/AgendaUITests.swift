//
//  AgendaViewTest.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 11.06.2022.
//

import XCTest
@testable import Agenda

class AgendaUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let device = XCUIDevice.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    /**
     In this test we check that everything is correctly displayed on the screen
     */
    func testAgendaViewModule() throws {
        let barButtons = app.navigationBars.buttons
        XCTAssertEqual(barButtons.count, 2)
        
        let monthProgressView = app.progressIndicators["monthProgressView"]
        let dayAndMonthLabel = app.staticTexts["dayAndMonthLabel"]
        let yearLabel = app.staticTexts["yearLabel"]
        let tableView = app.tables["tableView"]
        XCTAssertTrue(monthProgressView.exists)
        XCTAssertTrue(dayAndMonthLabel.exists)
        XCTAssertTrue(yearLabel.exists)
        XCTAssertTrue(tableView.exists)
    }
    
    /**
     We test opening GoalDetails module and providing correct (the same) data, as it was in cell with identifier `AgendaTableViewCell`. And then we close this module
     */
    func testGoalDetails() throws {
        // opening
        let tableView = app.tables["tableView"]
        let cell = tableView.cells["AgendaTableViewCell"].firstMatch
        XCTAssertTrue(cell.exists)
        XCTAssertTrue(cell.isHittable)
        
        // check for correct data providing
        let title = cell.staticTexts.element(boundBy: 1).label // text from titleLabel
        cell.tap()
        let goalTableView = app.tables["GoalTableView"]
        let goalCell = goalTableView.cells["GoalTableViewCell"].firstMatch
        let titleTextField = goalCell.textFields["titleTextField"]
        
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: goalTableView)
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(title, titleTextField.value as! String)
        XCTAssertTrue(goalTableView.exists)
        XCTAssertTrue(goalCell.exists)
        // closing
        let backButton = app.navigationBars.buttons.firstMatch
        backButton.tap()
        XCTAssertFalse(goalTableView.exists)
        XCTAssertFalse(goalCell.exists)
    }
    
    func testOpeningAndClosingAddGoal() throws {
        app.navigationBars.buttons["addBarButton"].tap()

        let tableView = app.tables["GoalTableView"]
        let currentCell = tableView.cells.element(boundBy: 2)
        let currentTextField = currentCell.textFields["currentTextField"]
        let aimCell = tableView.cells.element(boundBy: 3)
        let aimTextField = aimCell.textFields["aimTextField"]
        
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: tableView)
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(currentCell.exists)
        XCTAssertTrue(aimCell.exists)
        XCTAssertEqual(currentTextField.placeholderValue, "0")
        XCTAssertEqual(aimTextField.placeholderValue, "0")
        
        let cancel = app.navigationBars.buttons["cancelButtonItem"]
        cancel.tap()
        XCTAssertFalse(tableView.exists)
    }
    
    func testOpeningAlertWithoutDeletingGoal() throws {
        let tableView = app.tables.firstMatch
        let numberOfRowsBefore = tableView.cells.count
        let cell = tableView.cells.element(boundBy: 1)
        cell.swipeLeft()
        let deleteButton = cell.buttons.firstMatch
        deleteButton.tap()
        
        let actionSheet = app.sheets.firstMatch
        XCTAssertTrue(actionSheet.exists)
        
        actionSheet.buttons.element(boundBy: 1).tap()
        XCTAssertFalse(actionSheet.exists)
        
        let numberOfRowsAfter = tableView.cells.count
        XCTAssertEqual(numberOfRowsBefore, numberOfRowsAfter)
    }
    
    func testOpeningActionSheetAndDeletingGoal() {
        let tableView = app.tables.firstMatch
        let numberOfRowsBefore = tableView.cells.count
        let cell = tableView.cells.element(boundBy: 1)
        cell.swipeLeft()
        let deleteButton = cell.buttons.firstMatch
        deleteButton.tap()
        
        let actionSheet = app.sheets.firstMatch
        XCTAssertTrue(actionSheet.exists)
        
        actionSheet.buttons.firstMatch.tap()
        XCTAssertFalse(actionSheet.exists)
        
        let numberOfRowsAfter = tableView.cells.count
        XCTAssertNotEqual(numberOfRowsBefore, numberOfRowsAfter)
    }
}
