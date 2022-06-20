//
//  OnboardingContainerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class OnboardingModuleOutputMock: OnboardingModuleOutput {
    func onboardingModuleDidFinish() {
    }
}

class OnboardingContainerTests: XCTestCase {
    /**
     In the next 2 tests we check different cases of assembling `OnboardingContainer`: with and without provided `moduleOutput`
     */
    func testAssemblingWithFullContext() throws {
        let moduleOutput = OnboardingModuleOutputMock()
        let context = OnboardingContext(moduleOutput: moduleOutput)
        let container = OnboardingContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? OnboardingViewController,
              let presenter = container.input as? OnboardingPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
    }
    
    func testAssemblingWithoutModuleOutput() throws {
        let context = OnboardingContext()
        let container = OnboardingContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? OnboardingViewController,
              let presenter = container.input as? OnboardingPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
