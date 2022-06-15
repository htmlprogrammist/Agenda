//
//  AddGoalInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class AddGoalPresenterSpy: AddGoalInteractorOutput {
    var goalDidCreateBool = false
    
    func goalDidCreate() {
        goalDidCreateBool = true
    }
}

class AddGoalInteractorTests: XCTestCase {
    
    var interactor: AddGoalInteractor!
    var presenter: AddGoalPresenterSpy!
    var coreDataManager: CoreDataManagerSpy!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerSpy(containerName: "Agenda")
        presenter = AddGoalPresenterSpy()
        interactor = AddGoalInteractor(coreDataManager: coreDataManager)
        interactor.output = presenter
    }

    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        coreDataManager = nil
    }
    
    /**
     Because of usage asynchronous creating goal (because it has no affect on view (except slight hanging), so we may do this in the background for better perfomance).
     That is why we need to use `expectation` in our tests. The `fulFill()` method of the expectation is called inside `CoreDataManagerSpy` and is injected right down in the test.
     This method requires data to create goal and `Month` instance to create goal in that month.
     */
    func testCreatingGoal() {
        let expectation = self.expectation(description: "Creating goal expectation")
        coreDataManager.expectation = expectation
        let goalData = GoalData(title: "Sample", current: "\(20)", aim: "\(100)")
        let month = coreDataManager.fetchCurrentMonth()
        interactor.month = month
        
        interactor.createGoal(goalData: goalData)
        
        waitForExpectations(timeout: 1)
        XCTAssertTrue(presenter.goalDidCreateBool)
        XCTAssertTrue(coreDataManager.goalDidCreate)
    }
}
