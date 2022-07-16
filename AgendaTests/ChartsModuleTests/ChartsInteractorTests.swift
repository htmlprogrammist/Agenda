//
//  ChartsInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 06.07.2022.
//

import XCTest
@testable import Agenda

class ChartsInteractorTests: XCTestCase {
    
    var interactor: ChartsInteractor!
    var presenter: ChartsPresenterSpy!
    var months: [Month]!
    /// Initializes inside tests, not in `setUp` method
    var successfulSummary = Summary(
        icon: Icons.grid, title: Labels.Summary.percentOfSetGoals, tintColor: .systemTeal, measure: "% \(Labels.Summary.ofSetGoals)",
        kind: .percentOfSetGoals, description: Labels.Charts.percentOfSetGoalsDescription, isLessBetter: false, competion: { months in
            
            var result = [(String, Double)]()
            var totalSumOfCompletedGoals = 0
            var totalSumOfGoals = 0
            
            for month in months {
                var tempAverage = 0.0
                guard let goals = month.goals?.array as? [Goal] else {
                    return .failure(NSError(domain: "", code: 5, userInfo: [NSLocalizedDescriptionKey: "Invalid `goals` value"]))
                }
                totalSumOfGoals += goals.count
                goals.forEach { totalSumOfCompletedGoals += $0.current >= $0.aim ? 1 : 0 }
                
                tempAverage = round(100 * Double(totalSumOfCompletedGoals) / Double(totalSumOfGoals))
                result.append((month.date.formatTo("MMM YY"), tempAverage))
            }
            return .success(result)
        })
    var failureSummary = Summary(icon: Icons.grid, title: Labels.Summary.percentOfSetGoals, tintColor: .systemTeal, measure: "% \(Labels.Summary.ofSetGoals)", kind: .percentOfSetGoals, description: Labels.Charts.percentOfSetGoalsDescription, isLessBetter: false) { months in
        return .failure(NSError(domain: "", code: 5, userInfo: [NSLocalizedDescriptionKey: "Invalid `goals` value"]))
    }
    
    private let coreDataManagerStub = CoreDataManagerStub(containerName: "Agenda")
    
    override func setUpWithError() throws {
        months = coreDataManagerStub.fetchMonths()
        interactor = ChartsInteractor(months: months)
        presenter = ChartsPresenterSpy()
        interactor.output = presenter
    }
    
    override func tearDownWithError() throws {
        months = nil
        interactor = nil
        presenter = nil
    }
    
    func testComputeDataSuccessful() {
        interactor.computeData(by: successfulSummary)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool, "Data should be computed properly")
        XCTAssertNotNil(presenter.data, "Data should not be nil")
    }
    
    func testComputeDataFailute() {
        interactor.computeData(by: failureSummary)
        
        XCTAssertTrue(presenter.dataDidNotComputeBool)
        XCTAssertNil(presenter.data)
    }
}
