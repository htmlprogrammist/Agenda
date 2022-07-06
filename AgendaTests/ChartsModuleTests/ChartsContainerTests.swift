//
//  ChartsContainerTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 06.07.2022.
//

import XCTest
@testable import Agenda

class ChartsModuleOutputMock: ChartsModuleOutput {
    func chartsModuleDidFinish() {
    }
}

class ChartsContainerTests: XCTestCase {
    
    var context: ChartsContext!
    var container: ChartsContainer!
    
    var data: Summary!
    var months: [Month]!
    
    private let coreDataManagerStub = CoreDataManagerStub(containerName: "Agenda")
    
    override func setUpWithError() throws {
        data = Summary(
            icon: Icons.grid,
            title: Labels.Summary.percentOfSetGoals,
            tintColor: .systemTeal,
            measure: "% \(Labels.Summary.ofSetGoals)",
            kind: .percentOfSetGoals,
            description: Labels.Charts.percentOfSetGoalsDescription,
            isLessBetter: false,
            competion: { _ in return .success([(String, Double)]()) }
        )
        months = coreDataManagerStub.fetchMonths()
    }
    
    override func tearDownWithError() throws {
        context = nil
        container = nil
        data = nil
        months = nil
    }
    
    /**
     In the next 2 tests we check Assembly layer of _Charts_ module: **with** and **w/o** module output.
     */
    func testCreatingWithModuleOutput() throws {
        let moduleOutput = ChartsModuleOutputMock()
        context = ChartsContext(moduleOutput: moduleOutput, data: data, months: months)
        container = ChartsContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? ChartsViewController,
              let presenter = container.input as? ChartsPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
    }
    
    func testCreatingWithoutModuleOutput() throws {
        context = ChartsContext(data: data, months: months)
        container = ChartsContainer.assemble(with: context)
        
        XCTAssertNotNil(container.input, "Module input should not be nil")
        XCTAssertNotNil(container.viewController)
        XCTAssertNotNil(container.router)
        
        guard let viewController = container.viewController as? ChartsViewController,
              let presenter = container.input as? ChartsPresenter
        else {
            XCTFail("Container assebled with wrong components")
            return
        }
        XCTAssertIdentical(presenter.view, viewController)
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
