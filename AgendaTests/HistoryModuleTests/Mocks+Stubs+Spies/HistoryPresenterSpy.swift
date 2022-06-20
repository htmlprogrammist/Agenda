//
//  HistoryPresenterSpy.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 15.06.2022.
//

@testable import Agenda
import XCTest

class HistoryPresenterSpy: HistoryInteractorOutput {
    
    var viewModels: [MonthViewModel]!
    var dataDidNotFetchBool = false
    var month: Month!
    var moduleDependency: CoreDataManagerProtocol!
    
    var expectation: XCTestExpectation!
    
    func dataDidFetch(viewModels: [MonthViewModel]) {
        self.viewModels = viewModels
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    func dataDidNotFetch() {
        dataDidNotFetchBool = true
    }
    
    func showMonthDetailsModule(month: Month, moduleDependency: CoreDataManagerProtocol) {
        self.month = month
        self.moduleDependency = moduleDependency
    }
}
