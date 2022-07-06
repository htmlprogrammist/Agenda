//
//  ChartsInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 06.07.2022.
//

import XCTest
@testable import Agenda

class ChartsInteractorTests: XCTestCase {
    
    var interactor: ChartsInteractor!
    var presenter: ChartsPresenterSpy!
    var months: [Month]!
    
    private let coreDataManagerStub = CoreDataManagerStub(containerName: "Agenda")
    
    override func setUpWithError() throws {
        months = coreDataManagerStub.fetchMonths()
        interactor = ChartsInteractor(months: months)
        presenter = ChartsPresenterSpy()
        interactor.output = presenter
    }
    
    override func tearDownWithError() throws {
        months = nil
        interactor = nil
        presenter = nil
    }
    
    /**
     The number of tests equals the number of `SummaryKind` cases.
     
     Someday I will make it so that it will be possible to check how correctly the values are mathematically calculated, but so far so
     */
    func testComputingPercentOfSetGoals() throws {
        interactor.computeData(by: .percentOfSetGoals)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
    
    func testComputingCompletedGoals() throws {
        interactor.computeData(by: .completedGoals)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
    
    func testComputingUncompletedGoals() throws {
        interactor.computeData(by: .uncompletedGoals)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
    
    func testComputingAllGoals() throws {
        interactor.computeData(by: .allGoals)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
}
