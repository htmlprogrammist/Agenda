//
//  CoreDataManagerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 11.06.2022.
//

import XCTest
import CoreData
@testable import Agenda

class CoreDataManagerTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    var month: Month!
    
    let calendarDate = Calendar.current.dateComponents([.year, .month], from: Date())
    let dateFormatter = DateFormatter()
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManager(containerName: "Agenda")
        // TODO: Rewrite NSManagedObjectContext with temporary storage (in-memory)
        month = Month(context: coreDataManager.managedObjectContext)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        month.date = dateFormatter.date(from: "01.\(calendarDate.month ?? 0).\((calendarDate.year ?? 1970) - 1)") ?? Date()
    }
    
    override func tearDownWithError() throws {
        coreDataManager.managedObjectContext.delete(month)
        coreDataManager = nil
        month = nil
    }
    
    /**
     The next two tests will check for providing months. Both of them should not throw an error or return nil 
     `fetchCurrentMonth(:)` method must always return month instance
     `fetchMonths(:)` method must always return array of months
     */
    func testFetchingCurrentMonth() throws {
        XCTAssertNoThrow(coreDataManager.fetchCurrentMonth())
    }
    
    func testFetchingArrayOfMonths() throws {
        let months = coreDataManager.fetchMonths()
        XCTAssertNotNil(months, "Months were not fetched successfully")
    }
    
    /**
     This test checks for creating goal in sample month. Let's go by block
     First of all, we need to create sample data of type `GoalData`. Create sample `goalData` and use `createGoal(data:, in:)` method of CoreDataManager
     And the last block contains `createdGoal` variable. It is the only created goal, so we can use `first` property
     */
    func testCreatingGoal() throws {
        let goalData = GoalData(title: "Sample goal", current: String(75), aim: String(100), notes: "")
        coreDataManager.createGoal(data: goalData, in: month)
        
        let createdGoal = month.goals?.array.first as? Goal
        XCTAssertNotNil(createdGoal, "Created goal should not be nil")
        XCTAssertEqual(createdGoal?.month, month, "Months of the created goal and sample one should be the same")
        XCTAssertEqual(createdGoal?.name, goalData.title)
        XCTAssertEqual("\(createdGoal?.aim ?? 0)", goalData.aim)
        XCTAssertEqual("\(createdGoal?.current ?? 0)", goalData.current)
        XCTAssertEqual(createdGoal?.notes, goalData.notes)
    }
    
    /**
     Rewrinting goal requires two parameters: new `GoalData` and `Goal`, where old data will be rewritten
     We need to create 2 `GoalData` instances with the old and new data respectively
     Then we need to create goal, using `startGoalData` and rewrite its' data. It is the only created goal, so we can use `first` property
     In the end, we test parameters that differ
     */
    func testRewritingGoalsData() throws {
        let startGoalData = GoalData(title: "Sample goal", current: String(75), aim: String(100), notes: "")
        let newGoalData = GoalData(title: "Sample goal", current: String(100), aim: String(100), notes: "Sample goal notes")
        
        coreDataManager.createGoal(data: startGoalData, in: month)
        let createdGoal = month.goals?.array.first as? Goal
        if let goal = createdGoal {
            coreDataManager.updateGoal(with: newGoalData, in: goal)
        } else {
            XCTFail("Created goal should not be nil")
        }
        XCTAssertNotNil(createdGoal, "Created goal should not be nil")
        XCTAssertNotEqual("\(createdGoal?.current ?? 0)", startGoalData.current)
        XCTAssertNotEqual(createdGoal?.notes, startGoalData.notes)
    }
    
    /**
     To check reordering we need to create sample goals. The first one will be moved from the first place to last, so their order will look like this: _"2, 3, 1"_
     We replace and get array of goals of the current month.
     Then we test every sample goals' names (to simplify, since the `name` property  is enough for us)
     */
    func testReorderingGoals() throws {
        for i in 1...3 {
            let goalData = GoalData(title: "Sample goal \(i)", current: "\(75 + i * 5)", aim: "\(100)", notes: "")
            coreDataManager.createGoal(data: goalData, in: month)
        }
        let firstGoal = month.goals?.array.first as? Goal
        
        if let goal = firstGoal {
            coreDataManager.replaceGoal(goal, in: month, from: 0, to: 2)
        } else {
            XCTFail("Goal should not be nil")
        }
        let goals = month.goals?.array as? [Goal]
        
        XCTAssertNotNil(goals, "Goals should not be nil")
        XCTAssertEqual(goals?.first?.name, "Sample goal 2") // Goal #2 is the first
        XCTAssertEqual(goals?.last?.name, "Sample goal 1") // Goal #1 is the last
        XCTAssertNotEqual(goals?.last?.name, "Sample goal 3") // Goal #3 is not the last one now
    }
}
