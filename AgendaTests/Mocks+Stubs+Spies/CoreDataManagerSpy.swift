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
    
    var goalDidCreate = false
    var goalDidRewrite = false
    var goalDidReplace = false
    var monthDidDelete = false
    var goalDidDelete = false
    
    override func createGoal(data: GoalData, in month: Month) {
        super.createGoal(data: data, in: month)
        goalDidCreate = true
    }
    
    override func rewriteGoal(with data: GoalData, in goal: Goal) {
        goalDidRewrite = true
    }
    
    override func replaceGoal(_ goal: Goal, in month: Month, from: Int, to: Int) {
        self.goal = goal
        self.month = month
        self.fromTo = (from, to)
        goalDidReplace = true
        
        expectation.fulfill()
    }
    
    override func deleteMonth(month: Month) {
        monthDidDelete = true
    }
    
    override func deleteGoal(goal: Goal) {
        goalDidDelete = true
        expectation.fulfill()
    }
}
