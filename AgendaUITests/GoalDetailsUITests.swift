//
//  GoalDetailsUITests.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 18.06.2022.
//

import XCTest

class GoalDetailsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let device = XCUIDevice.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
        /// Opening GoalDetails module from Agenda module
        let agendaTableView = app.tables["tableView"]
        let cell = agendaTableView.cells.firstMatch
        cell.tap()
        let goalsTableView = app.tables["GoalTableView"]
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: goalsTableView)
        wait(for: [expectation], timeout: 5)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    
    func testGoalDetailsViewExists() {
        let backButton = app.navigationBars.buttons.firstMatch
        let saveBarButton = app.navigationBars.buttons["saveBarButton"]
        let tableView = app.tables["GoalTableView"]
        let titleCell = tableView.cells.element(boundBy: 0)
        let notesCell = tableView.cells.element(boundBy: 1)
        let currentCell = tableView.cells.element(boundBy: 2)
        let aimCell = tableView.cells.element(boundBy: 3)
        
        XCTAssertTrue(backButton.exists)
        XCTAssertTrue(saveBarButton.exists)
        XCTAssertFalse(saveBarButton.isEnabled)
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(titleCell.exists)
        XCTAssertTrue(notesCell.exists)
        XCTAssertTrue(currentCell.exists)
        XCTAssertTrue(aimCell.exists)
    }
    
    func testWithSomeChangesInTitle() {
        let saveBarButton = app.navigationBars.buttons["saveBarButton"]
        let tableView = app.tables["GoalTableView"]
        let titleCell = tableView.cells.element(boundBy: 0)
        let titleTextField = titleCell.textFields["titleTextField"]
        
        titleTextField.tap()
        titleTextField.typeText("Sample title")
        
        XCTAssertTrue(saveBarButton.isEnabled)
    }
    
    func testWithSomeChangesInNotes() {
        let saveBarButton = app.navigationBars.buttons["saveBarButton"]
        let tableView = app.tables["GoalTableView"]
        let notesCell = tableView.cells.element(boundBy: 1)
        let notesTextView = notesCell.textViews["notesTextView"]
        
        notesTextView.tap()
        notesTextView.typeText("Sample title")
        
        XCTAssertTrue(saveBarButton.isEnabled)
    }
    
    func testWithSomeChangesInCurrentTextField() {
        let saveBarButton = app.navigationBars.buttons["saveBarButton"]
        let tableView = app.tables["GoalTableView"]
        let currentCell = tableView.cells.element(boundBy: 2)
        let currentTextField = currentCell.textFields["currentTextField"]
        
        currentTextField.tap()
        currentTextField.typeText("100")
        
        XCTAssertTrue(saveBarButton.isEnabled)
    }
    
    func testWithSomeChangesInAimTextField() {
        let saveBarButton = app.navigationBars.buttons["saveBarButton"]
        let tableView = app.tables["GoalTableView"]
        let aimCell = tableView.cells.element(boundBy: 3)
        let aimTextField = aimCell.textFields["aimTextField"]
        
        aimTextField.tap()
        aimTextField.typeText("100")
        
        XCTAssertTrue(saveBarButton.isEnabled)
    }
    
    func testMakingSomeChangesAndThenBack() {
        let saveBarButton = app.navigationBars.buttons["saveBarButton"]
        let tableView = app.tables["GoalTableView"]
        let titleCell = tableView.cells.element(boundBy: 0)
        let titleTextField = titleCell.textFields["titleTextField"]
        let oldValue = titleTextField.value as! String
        
        titleTextField.tap()
        app.keys["delete"].tap()
        
        titleTextField.typeText("\(oldValue.last!)")
        XCTAssertFalse(saveBarButton.isEnabled)
    }
}
