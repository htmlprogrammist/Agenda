//
//  SummaryPresenter.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 16.06.2022.
//

import XCTest
@testable import Agenda

class SummaryPresenterSpy: SummaryInteractorOutput {
    
    var dataDidNotFetchBool = false
    var data: [Summary]!
    var summary: Summary!
    var months: [Month]!
    
    var expectation: XCTestExpectation!
    
    func dataDidFetch(data: [Summary]) {
        self.data = data
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    func dataDidNotFetch() {
        dataDidNotFetchBool = true
    }
    
    func provideDataForChartsModule(data: Summary, months: [Month]) {
        self.summary = data
        self.months = months
    }
}
