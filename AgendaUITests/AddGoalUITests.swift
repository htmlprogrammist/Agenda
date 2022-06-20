//
//  AddGoalUITests.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 17.06.2022.
//

import XCTest

/*
 checkBarButtonEnabled можно проверить через .isHittable
 */

class AddGoalUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let device = XCUIDevice.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        /// Opening AddGoal module every time the tests start
        app.navigationBars.buttons["addBarButton"].tap()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    
    func testAddGoalViewExists() throws {
        let cancelBarButton = app.navigationBars.buttons["cancelButtonItem"]
        let doneBarButton = app.navigationBars.buttons["doneButtonItem"]
        let tableView = app.tables["GoalTableView"]
        let titleCell = tableView.cells.element(boundBy: 0)
        let notesCell = tableView.cells.element(boundBy: 1)
        let currentCell = tableView.cells.element(boundBy: 2)
        let aimCell = tableView.cells.element(boundBy: 3)
        
        XCTAssertTrue(cancelBarButton.exists)
        XCTAssertTrue(cancelBarButton.isEnabled)
        XCTAssertTrue(doneBarButton.exists)
        XCTAssertFalse(doneBarButton.isEnabled)
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(titleCell.exists)
        XCTAssertTrue(notesCell.exists)
        XCTAssertTrue(currentCell.exists)
        XCTAssertTrue(aimCell.exists)
    }
    
    /**
     Before _Done_ button is enabled, user need to fill 3 required text fields. In the next 3 tests we check for button's enabling. Only last one will have effect
     */
    func testAddGoalWithOneOfThreeFields() throws {
        let tableView = app.tables["GoalTableView"]
        let doneBarButton = app.navigationBars.buttons["doneButtonItem"]
        let cell = tableView.cells["GoalTableViewCell"].firstMatch
        let titleTextField = cell.textFields["titleTextField"]
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: tableView)
        wait(for: [expectation], timeout: 5)
        
        titleTextField.tap()
        titleTextField.typeText("Sample title")
        
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(cell.exists)
        XCTAssertTrue(titleTextField.exists)
        XCTAssertFalse(doneBarButton.isEnabled)
    }
    
    func testAddGoalWithTwoOfThreeFields() throws {
        let tableView = app.tables["GoalTableView"]
        let doneBarButton = app.navigationBars.buttons["doneButtonItem"]
        let currentCell = tableView.cells.element(boundBy: 2)
        let currentTextField = currentCell.textFields["currentTextField"]
        let aimCell = tableView.cells.element(boundBy: 3)
        let aimTextField = aimCell.textFields["aimTextField"]
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: tableView)
        wait(for: [expectation], timeout: 5)
        
        currentTextField.tap()
        currentTextField.typeText("120")
        aimTextField.tap()
        aimTextField.typeText("600")
        
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(currentCell.exists)
        XCTAssertTrue(aimCell.exists)
        XCTAssertFalse(doneBarButton.isEnabled)
    }
    
    func testAddGoalWithFullThreeFields() throws {
        let tableView = app.tables["GoalTableView"]
        let doneBarButton = app.navigationBars.buttons["doneButtonItem"]
        let titleCell = tableView.cells.element(boundBy: 0)
        let currentCell = tableView.cells.element(boundBy: 2)
        let aimCell = tableView.cells.element(boundBy: 3)
        
        let titleTextField = titleCell.textFields["titleTextField"]
        let currentTextField = currentCell.textFields["currentTextField"]
        let aimTextField = aimCell.textFields["aimTextField"]
        
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: tableView)
        wait(for: [expectation], timeout: 5)
        
        titleTextField.tap()
        titleTextField.typeText("Sample title")
        currentTextField.tap()
        currentTextField.typeText("120")
        aimTextField.tap()
        aimTextField.typeText("600")
        
        XCTAssertTrue(doneBarButton.isEnabled)
    }
}
