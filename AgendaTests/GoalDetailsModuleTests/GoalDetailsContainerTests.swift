//
//  GoalDetailsContainerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class GoalDetailsModuleOutputMock: GoalDetailsModuleOutput {
    func goalDetailsModuleDidFinish() {
    }
}

class GoalDetailsContainerTests: XCTestCase {
    
    var coreDataManager: CoreDataManagerStub!
    var goal: Goal!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerStub(containerName: "Agenda")
        
        let month = coreDataManager.fetchCurrentMonth()
        coreDataManager.createGoal(data: GoalData(title: "Sample", current: "\(10)", aim: "\(100)"), in: month)
        guard let goal = month.goals?.array.first as? Goal else {
            XCTFail("Goal should not be nil")
            return
        }
        self.goal = goal
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
        goal = nil
    }
    
    /**
     In the next 2 tests we check different cases of assembling `GoalDetailsContainer`: with and without provided `moduleOutput`
     */
    func testAssemblingWithFullContext() {
        let moduleOutput = GoalDetailsModuleOutputMock()
        let context = GoalDetailsContext(moduleOutput: moduleOutput, moduleDependency: coreDataManager, goal: goal)
        let container = GoalDetailsContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertIdentical(moduleOutput, container.input.moduleOutput, "All injected dependencies should be identical")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
    }
    
    func testAssemblingWithoutModuleOutput() {
        let context = GoalDetailsContext(moduleDependency: coreDataManager, goal: goal)
        let container = GoalDetailsContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNil(container.input.moduleOutput, "Module output was not provided and should be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
    }
}
