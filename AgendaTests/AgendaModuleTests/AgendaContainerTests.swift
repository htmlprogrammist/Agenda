//
//  AgendaContainerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 12.06.2022.
//

import XCTest
@testable import Agenda

class AgendaModuleOutputMock: AgendaModuleOutput {
    func monthDetailsModuleDidFinish() {}
}

class AgendaContainerTests: XCTestCase {
    
    var container: AgendaContainer!
    var context: AgendaContext!

    override func setUpWithError() throws {
        context = AgendaContext(moduleDependency: CoreDataManagerMock())
        container = AgendaContainer.assemble(with: context)
    }

    override func tearDownWithError() throws {
        context = nil
        container = nil
    }

    /**
     In the next tests we will check that the module consists of the correct parts and all dependencies are filled in.
     The tests will differ by creating different contexts
     */
    func testAssemblingWithFullContext() {
        let moduleOutput = AgendaModuleOutputMock()
        let coreDataManager = CoreDataManagerStub(containerName: "Agenda")
        let month = coreDataManager.fetchCurrentMonth()
        
        context = AgendaContext(moduleOutput: moduleOutput, moduleDependency: coreDataManager, month: month)
        container = AgendaContainer.assemble(with: context)
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertIdentical(moduleOutput, container.input.moduleOutput, "All injected dependencies should be identical")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
    }
    
    func testAssemblingWithoutMonth() {
        let moduleOutput = AgendaModuleOutputMock()
        
        context = AgendaContext(moduleOutput: moduleOutput, moduleDependency: CoreDataManagerMock())
        container = AgendaContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertIdentical(moduleOutput, container.input.moduleOutput, "All injected dependencies should be identical")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
    }
    
    func testAssemblingWithoutModuleOutputAndMonth() {
        context = AgendaContext(moduleDependency: CoreDataManagerMock())
        container = AgendaContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNil(container.input.moduleOutput, "Module output was not provided and should be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
    }
}
