//
//  AddGoalContainerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class AddGoalModuleOutputMock: AddGoalModuleOutput {
    func addGoalModuleDidFinish() {
    }
}

class AddGoalContainerTests: XCTestCase {
    
    var coreDataManager: CoreDataManagerStub!
    var month: Month!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerStub(containerName: "Agenda")
        month = coreDataManager.fetchCurrentMonth()
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
        month = nil
    }
    
    /**
     In the next 2 tests we check different cases of assembling `AddGoalContainer`: with and without provided `moduleOutput`
     */
    func testAssemblingWithFullContext() throws {
        let moduleOutput = AddGoalModuleOutputMock()
        let context = AddGoalContext(moduleOutput: moduleOutput, moduleDependency: coreDataManager, month: month)
        let container = AddGoalContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? AddGoalViewController,
              let presenter = container.input as? AddGoalPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
    }
    
    func testAssemblingWithoutModuleOutput() throws {
        let context = AddGoalContext(moduleDependency: coreDataManager, month: month)
        let container = AddGoalContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? AddGoalViewController,
              let presenter = container.input as? AddGoalPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
