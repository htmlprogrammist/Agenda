//
//  CoreDataManagerSpy.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import Foundation
import CoreData
@testable import Agenda
import XCTest

class CoreDataManagerSpy: CoreDataManagerStub {
    
    var goal: Goal!
    var month: Month!
    var fromTo: (Int, Int)!
    var expectation: XCTestExpectation!
    var failFetchingMonth = false
    
    var goalDidCreate = false
    var goalDidRewrite = false
    var goalDidReplace = false
    var monthDidDelete = false
    var goalDidDelete = false
    
    override func fetchMonths() -> [Month]? {
        guard !failFetchingMonth else {
            return nil
        }
        return super.fetchMonths()
    }
    
    override func createGoal(data: GoalData, in month: Month) {
        super.createGoal(data: data, in: month)
        goalDidCreate = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    override func rewriteGoal(with data: GoalData, in goal: Goal) {
        goalDidRewrite = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    override func replaceGoal(_ goal: Goal, in month: Month, from: Int, to: Int) {
        self.goal = goal
        self.month = month
        self.fromTo = (from, to)
        goalDidReplace = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    override func deleteMonth(month: Month) {
        self.month = month
        monthDidDelete = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    override func deleteGoal(goal: Goal) {
        goalDidDelete = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
}
