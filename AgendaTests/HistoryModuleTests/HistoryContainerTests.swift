//
//  HistoryContainerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class HistoryModuleOutputMock: HistoryModuleOutput {
}

class HistoryContainerTests: XCTestCase {
    
    var coreDataManager: CoreDataManagerMock!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerMock()
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
    }
    
    /**
     In the next 2 tests we check different cases of assembling `HistoryContainer`: with and without provided `moduleOutput`
     */
    func testAssemblingWithFullContext() throws {
        let moduleOutput = HistoryModuleOutputMock()
        let context = HistoryContext(moduleOutput: moduleOutput, moduleDependency: coreDataManager)
        let container = HistoryContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? HistoryViewController,
              let presenter = container.input as? HistoryPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
    }
    
    func testAssemblingWithoutModuleOutput() throws {
        let context = HistoryContext(moduleDependency: coreDataManager)
        let container = HistoryContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNil(container.input.moduleOutput, "Module output was not provided and should be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? HistoryViewController,
              let presenter = container.input as? HistoryPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
