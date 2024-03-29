//
//  SummaryContainerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class SummaryModuleOutputMock: SummaryModuleOutput {
}

class SummaryContainerTests: XCTestCase {
    
    var coreDataManager: CoreDataManagerMock!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerMock()
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
    }
    
    /**
     In the next 2 tests we check different cases of assembling `SummaryContainer`: with and without provided `moduleOutput`
     */
    func testAssemblingWithFullContext() throws {
        let moduleOutput = SummaryModuleOutputMock()
        let context = SummaryContext(moduleOutput: moduleOutput, moduleDependency: coreDataManager)
        let container = SummaryContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? SummaryViewController,
              let presenter = container.input as? SummaryPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
    }
    
    func testAssemblingWithoutModuleOutput() throws {
        let context = SummaryContext(moduleDependency: coreDataManager)
        let container = SummaryContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? SummaryViewController,
              let presenter = container.input as? SummaryPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
