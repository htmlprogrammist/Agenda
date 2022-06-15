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
    func testCreatingWithFullContext() {
        let moduleOutput = OnboardingModuleOutputMock()
        let context = OnboardingContext(moduleOutput: moduleOutput)
        let container = OnboardingContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertIdentical(moduleOutput, container.input.moduleOutput, "All injected dependencies should be identical")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
    }
    
    func testCreatingWithoutModuleOutput() {
        let context = OnboardingContext()
        let container = OnboardingContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNil(container.input.moduleOutput, "Module output was not provided and should be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
    }
}
