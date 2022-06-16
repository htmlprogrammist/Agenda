//
//  SummaryInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class SummaryInteractorTests: XCTestCase {
    
    var interactor: SummaryInteractor!
    var presenter: SummaryPresenterSpy!
    var coreDataManager: CoreDataManagerSpy!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerSpy(containerName: "Agenda")
        presenter = SummaryPresenterSpy()
        interactor = SummaryInteractor(coreDataManager: coreDataManager)
        interactor.output = presenter
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        coreDataManager = nil
    }
    
    func testPerfomingFetchWithError() {
        coreDataManager.failFetchingMonth = true
        interactor.performFetch()
        
        XCTAssertTrue(presenter.dataDidNotFetchBool)
    }
    
    func testPerfomingFetchWithEmptyData() {
        let expectation = self.expectation(description: "Fetching months in HistoryInteractor")
        presenter.expectation = expectation
        
        interactor.performFetch()
        
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(presenter.data, "Provided data should not be nil")
        
        presenter.data.forEach { summary in
            if summary.number > 0 {
                XCTFail("There should not be any data")
            }
        }
    }
    
    func testPerfomingFetchWithSomeData() {
        let expectation = self.expectation(description: "Fetching months in HistoryInteractor")
        presenter.expectation = expectation
        
        interactor.summaries = [
            Summary(icon: Icons.grid, title: Labels.Summary.percentOfSetGoals, tintColor: .systemTeal, measure: "% \(Labels.Summary.ofSetGoals)"),
            Summary(icon: Icons.checkmark, title: Labels.Summary.completedGoals, tintColor: .systemGreen, measure: Labels.Summary.goalsDeclension),
            Summary(icon: Icons.xmark, title: Labels.Summary.uncompletedGoals, tintColor: .systemRed, measure: Labels.Summary.goalsDeclension),
            Summary(icon: Icons.sum, title: Labels.Summary.allGoals, tintColor: .systemOrange, measure: Labels.Summary.goalsDeclension)
        ]
        let goalData1 = GoalData(title: "Sample 1", current: "\(75)", aim: "\(100)")
        let goalData2 = GoalData(title: "Sample 2", current: "\(100)", aim: "\(100)")
        coreDataManager.createGoal(data: goalData1, in: coreDataManager.month1)
        coreDataManager.createGoal(data: goalData2, in: coreDataManager.month2)
        
        interactor.performFetch()
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(presenter.data, "Provided data should not be nil")
        XCTAssertEqual(presenter.data[0].number, 50) // percentOfSetGoals
        XCTAssertEqual(presenter.data[1].number, 1) // completedGoals
        XCTAssertEqual(presenter.data[2].number, 1) // uncompletedGoals
        XCTAssertEqual(presenter.data[3].number, 2) // allGoals
    }
}
