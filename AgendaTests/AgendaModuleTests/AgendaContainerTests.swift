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
        XCTAssertNotNil(container.router)
        XCTAssertNotNil(container.viewController)
        
        guard let viewController = container.viewController as? AgendaViewController,
              let presenter = container.input as? AgendaPresenter,
              let _ = container.router as? AgendaRouter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertFalse(viewController.isAgenda, "Since month was provided, this VC is no longer 'Agenda' but 'MonthDetails'")
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
    }
    
    func testAssemblingWithoutMonth() {
        let moduleOutput = AgendaModuleOutputMock()
        
        context = AgendaContext(moduleOutput: moduleOutput, moduleDependency: CoreDataManagerMock())
        container = AgendaContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? AgendaViewController,
              let presenter = container.input as? AgendaPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertTrue(viewController.isAgenda, "Since month was not provided, this VC is 'Agenda'")
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
    }
    
    func testAssemblingWithoutModuleOutputAndMonth() {
        context = AgendaContext(moduleDependency: CoreDataManagerMock())
        container = AgendaContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? AgendaViewController,
              let presenter = container.input as? AgendaPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertTrue(viewController.isAgenda, "Since month was not provided, this VC is 'Agenda'")
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
