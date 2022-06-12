//
//  AgendaInteractorTest.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 11.06.2022.
//

import XCTest
@testable import Agenda

class AgendaInteractorTest: XCTestCase {
    
    var interactor: AgendaInteractor!
    var presenter: AgendaPresenterSpy!
    
    let stubCoreDataManager = CoreDataManagerStub(containerName: "Agenda")
    
    override func setUpWithError() throws {
        presenter = AgendaPresenterSpy()
        interactor = AgendaInteractor(coreDataManager: stubCoreDataManager)
        interactor.output = presenter
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
    }
    
    /**
     The next 2 tests check for fetching month: the first one without month provided, the next one - with.
     We use stub on CoreDataManager, recreate interactor with new CDM injected, and then use method under testing
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
        let month = stubCoreDataManager.fetchCurrentMonth() // creates new month
        if let month = month {
            interactor.month = month
        }
        interactor.fetchMonthGoals()
        
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        XCTAssertNotNil(interactor.month, "Month should not be nil")
        XCTAssertNotNil(presenter.viewModels, "View models should not be nil")
        XCTAssertNotNil(presenter.monthInfo, "Month info should not be nil")
        XCTAssertNotNil(presenter.date, "Date should not be nil")
    }
    
    /**
     The next 2 tests describe providing data from presenter to router, when it's time to create new module with some data provided by interactor
     Firstly, we create stub core data manager, recreate interactor with injecting stub and month.
     Then we need to create sample goals to our month, so there will be possibility to get something.
     In the end, we check that provided goal  is not nil and moduleDependency was provided clearly
     */
    func testGettingGoalAtIndexPath() {
        let month = stubCoreDataManager.fetchCurrentMonth() // creates new month
        if let month = month {
            interactor.month = month
            let goalData = GoalData(title: "Sample goal", current: "\(75)", aim: "\(100)", notes: "")
            for _ in 0..<3 {
                stubCoreDataManager.createGoal(data: goalData, in: month)
            }
        }
        let indexPath = IndexPath(row: 0, section: 0)
        
        interactor.getGoalAt(indexPath)
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        XCTAssertNotNil(presenter.goalProvided, "Goal was not provided by interactor")
        XCTAssertIdentical(stubCoreDataManager, presenter.dependencyProvided)
    }
    
    func testDataProvidingForAddingGoalModule() {
        let month = stubCoreDataManager.fetchCurrentMonth() // creates new month
        if let month = month {
            interactor.month = month
        }
        
        interactor.provideDataForAdding()
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        XCTAssertNotNil(presenter.monthProvided, "Month was not provided by interactor")
        XCTAssertIdentical(stubCoreDataManager, presenter.dependencyProvided)
    }
    /*
     In this test we simulate opening onboarding, and then check:
     If user hasn't onboarded, onboarding will be shown, otherwise - on the contrary
     */
    func testCheckForOnboarding() {
        interactor.checkForOnboarding()
        let settings = UserSettings()
        XCTAssertNotEqual(settings.hasOnboarded, presenter.onboardingDidShow)
    }
    
    /**
     Firstly, we create month with sample goals
     Then we use method under test that will replace first goal to the last place and check that there was not any errors
     */
    func testReplacingGoal() {
        let month = stubCoreDataManager.fetchCurrentMonth() // creates new month
        if let month = month {
            interactor.month = month
            
            for i in 1...3 {
                let goalData = GoalData(title: "Sample goal \(i)", current: "\(75 + i * 5)", aim: "\(100)", notes: "")
                stubCoreDataManager.createGoal(data: goalData, in: month)
            }
        }
        
        interactor.replaceGoal(from: 0, to: 2)
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        
        if let goals = month?.goals?.array as? [Goal] {
            XCTAssertNotEqual(goals.first?.name, "Sample goal 1") // 1st goal is not the first now
            XCTAssertEqual(goals.last?.name, "Sample goal 1")
            XCTAssertNotEqual(goals.last?.name, "Sample goal 3") // 3rd goal is not the last
        }
    }
    
    /**
     We delete first goal (at index path 0 and 0) from sample goals array, then check, that this array does not contains deleted goal
     */
    func testDeletingGoal() {
        let indexPath = IndexPath(row: 0, section: 0)
        var deletedGoal: Goal!
        
        let month = stubCoreDataManager.fetchCurrentMonth() // creates new month
        if let month = month {
            interactor.month = month
            
            for i in 1...3 {
                let goalData = GoalData(title: "Sample goal \(i)", current: "\(75 + i * 5)", aim: "\(100)", notes: "")
                stubCoreDataManager.createGoal(data: goalData, in: month)
            }
        }
        if let goal = month?.goals?.object(at: indexPath.row) as? Goal {
            deletedGoal = goal
        }
        interactor.deleteItem(at: indexPath)
        
        if let goals = month?.goals?.array as? [Goal] {
            XCTAssertFalse(goals.contains(deletedGoal))
        }
    }
}
