//
//  AgendaInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 11.06.2022.
//

import XCTest
@testable import Agenda

class AgendaInteractorTests: XCTestCase {
    
    var interactor: AgendaInteractor!
    var presenter: AgendaPresenterSpy!
    
    let coreDataManager = CoreDataManagerSpy(containerName: "Agenda")
    
    override func setUpWithError() throws {
        presenter = AgendaPresenterSpy()
        interactor = AgendaInteractor(coreDataManager: coreDataManager)
        interactor.output = presenter
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
    }
    
    /**
     The next 2 tests check for fetching month: the first one without month provided, the next one - with.
     We use stub on Core Data manager, recreate interactor with new Core Data manager injected, and then use method under testing
     */
    func testFetchMonthGoalsWithMonthNil() {
        interactor.fetchMonthGoals()
        
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        XCTAssertNotNil(interactor.month, "Month should not be nil")
        XCTAssertNotNil(presenter.viewModels, "View models should not be nil")
        XCTAssertNotNil(presenter.monthInfo, "Month info should not be nil")
        XCTAssertNotNil(presenter.date, "Date should not be nil")
    }
    
    func testFetchMonthGoalsWithProvidedMonth() {
        let month = coreDataManager.fetchCurrentMonth() // creates new month
        interactor.month = month
        
        interactor.fetchMonthGoals()
        
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        XCTAssertNotNil(interactor.month, "Month should not be nil")
        XCTAssertNotNil(presenter.viewModels, "View models should not be nil")
        XCTAssertNotNil(presenter.monthInfo, "Month info should not be nil")
        XCTAssertNotNil(presenter.date, "Date should not be nil")
    }
    
    /**
     The next 2 tests describe providing data from presenter to router, when it's time to create new module with some data provided by interactor
     Firstly, we create stub Core Data manager, recreate interactor with injecting stub and month.
     Then we need to create sample goals to our month, so there will be possibility to get something.
     In the end, we check that provided goal is not nil and moduleDependency was provided clearly
     */
    func testGettingGoalAtIndexPath() {
        let month = coreDataManager.fetchCurrentMonth() // creates new month
        interactor.month = month
        coreDataManager.createGoal(data: GoalData(title: "Sample", current: "\(50)", aim: "\(100)"), in: month)
        
        interactor.getGoal(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        XCTAssertTrue(presenter.goalDidProvide, "Goal was not provided by interactor")
        XCTAssertIdentical(coreDataManager, presenter.dependencyProvided)
    }
    
    func testDataProvidingForAddingGoalModule() {
        let month = coreDataManager.fetchCurrentMonth() // creates new month
        interactor.month = month
        
        interactor.provideDataForAdding()
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        XCTAssertNotNil(presenter.monthProvided, "Month was not provided by interactor")
        XCTAssertIdentical(coreDataManager, presenter.dependencyProvided)
    }
    
    /**
     We simulate opening onboarding, and then check: if user hasn't onboarded, onboarding will be shown, otherwise - on the contrary.
     So, the `settings.hasOnboarded` and `presenter.onboardingDidShow` will never be equal.
     If user **has onboarded**, the onboarding **will not be shown** and vice versa.
     */
    func testCheckForOnboarding() {
        interactor.checkForOnboarding()
        let settings = UserSettings()
        XCTAssertNotEqual(settings.hasOnboarded, presenter.onboardingDidShow)
    }
    
    /**
     We test providing all the data to the Core Data manager.
     Because of usage asynchronous replacing goal (because it has no affect on view (except slight hanging), so we may do this in the background for better perfomance).
     That is why we need to use `expectation` in our tests. The `fulFill()` method of the expectation is called inside `CoreDataManagerSpy` and is injected right down in the test.
     We need to create sample goal, because the `replaceGoal(from:, to:)` method of Interactor provide `Goal` instance at `from` index to the replacing method of Core Data Manager.
     */
    func testReplacingGoal() {
        let expectation = self.expectation(description: "Replacing Goal Expectation")
        let month = coreDataManager.fetchCurrentMonth() // creates new month
        interactor.month = month
        coreDataManager.createGoal(data: GoalData(title: "Sample", current: "\(50)", aim: "\(100)"), in: month)
        
        coreDataManager.expectation = expectation
        interactor.replaceGoal(from: 0, to: 2)
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertTrue(coreDataManager.goalDidReplace)
        XCTAssertNotNil(coreDataManager.month)
        XCTAssertNotNil(coreDataManager.goal)
        XCTAssertNotNil(coreDataManager.fromTo)
    }
    
    /**
     Same as in the previous test, we use asynchronous deleting goal (because it has no affect on view (except slight hanging), so we may do this in the background for better perfomance).
     That is why we need to use `expectation` in our tests. The `fulFill()` method of the expectation is called inside `CoreDataManagerSpy` and is injected right down in the test.
     We assert true, that the goal was deleted by Core Data Manager.
     We need to create sample goal, because `deleteItem(at:)` method of Interactor requires `IndexPath` of the goal to be deleted to get its' instance and provides it to the Core Data Manager
     */
    func testDeletingGoal() {
        let expectation = self.expectation(description: "Deleting Goal Expectation")
        let month = coreDataManager.fetchCurrentMonth() // creates new month
        interactor.month = month
        coreDataManager.createGoal(data: GoalData(title: "Sample", current: "\(50)", aim: "\(100)"), in: month)
        
        coreDataManager.expectation = expectation
        interactor.deleteItem(at: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(coreDataManager.goalDidDelete)
    }
}
