//
//  HistoryInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class HistoryInteractorTests: XCTestCase {
    
    var interactor: HistoryInteractor!
    var presenter: HistoryPresenterSpy!
    var coreDataManager: CoreDataManagerSpy!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerSpy(containerName: "Agenda")
        presenter = HistoryPresenterSpy()
        interactor = HistoryInteractor(coreDataManager: coreDataManager)
        interactor.output = presenter
    }

    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        coreDataManager = nil
    }
    
    func testFetchingMonths() {
        let expectation = self.expectation(description: "Fetching months in HistoryInteractor")
        presenter.expectation = expectation
        
        interactor.performFetch()
        XCTAssertFalse(presenter.dataDidNotFetchBool)
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(presenter.viewModels, "View models should not be nil")
    }
    
    func testFetchingMonthsWithError() {
        coreDataManager.failFetchingMonth = true
        
        interactor.performFetch()
        XCTAssertTrue(presenter.dataDidNotFetchBool)
    }
    
    func testOpeningDetailsByMonth() {
        interactor.performFetch()
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        interactor.openDetailsByMonth(at: indexPath)
        
        XCTAssertNotNil(presenter.month, "Month provided for another module should not be nil")
        XCTAssertIdentical(coreDataManager, presenter.moduleDependency)
    }
    
    func testDeletingMonth() {
        let expectation = self.expectation(description: "Deleting month expectation")
        interactor.performFetch()
        coreDataManager.expectation = expectation
        
        let indexPath = IndexPath(row: 0, section: 0)
        interactor.deleteMonth(at: indexPath)
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(coreDataManager.month)
        XCTAssertTrue(coreDataManager.monthDidDelete)
    }
}
