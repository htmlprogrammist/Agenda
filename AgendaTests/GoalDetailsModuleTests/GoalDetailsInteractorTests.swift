//
//  GoalDetailsInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class GoalDetailsInteractorTests: XCTestCase {
    
    var interactor: GoalDetailsInteractor!
    var presenter: GoalDetailsPresenterSpy!
    var coreDataManager: CoreDataManagerSpy!
    
    let goalData = GoalData(title: "Sample", current: "\(10)", aim: "\(100)")
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerSpy(containerName: "Agenda")
        presenter = GoalDetailsPresenterSpy()
        interactor = GoalDetailsInteractor(coreDataManager: coreDataManager)
        interactor.output = presenter
        
        let month = coreDataManager.fetchCurrentMonth()
        coreDataManager.createGoal(data: goalData, in: month)
        guard let goal = month.goals?.array.first as? Goal else {
            XCTFail("Goal should not be nil")
            return
        }
        interactor.goal = goal
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        coreDataManager = nil
    }
    
    func testProvidingData() {
        interactor.provideData()
        
        XCTAssertEqual(presenter.goalData.title, goalData.title)
        XCTAssertEqual(presenter.goalData.current, goalData.current)
        XCTAssertEqual(presenter.goalData.aim, goalData.aim)
        XCTAssertEqual(presenter.goalData.notes, goalData.notes)
    }
    
    func testRewritingGoal() {
        let expectation = self.expectation(description: "Rewriting goal expectation")
        coreDataManager.expectation = expectation
        
        interactor.rewriteGoal(with: goalData)
        
        XCTAssertTrue(presenter.goalDidRewriteBool)
        waitForExpectations(timeout: 1)
        XCTAssertTrue(coreDataManager.goalDidRewrite)
    }
    
    func testCheckingBarButtonEnabledWithoutChanges() {
        interactor.checkBarButtonEnabled(goalData: goalData)
        
        XCTAssertFalse(presenter.barButtonFlag)
    }
    
    func testCheckingBarButtonEnabledWithChanges() {
        let changedGoalData = GoalData(title: "New title", current: "\(75)", aim: "\(100)")
        interactor.checkBarButtonEnabled(goalData: changedGoalData)
        
        XCTAssertTrue(presenter.barButtonFlag)
    }
}
