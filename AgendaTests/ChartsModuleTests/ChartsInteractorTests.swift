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
    var summary: Summary!
    
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
        summary = nil
    }
    
    /**
     The number of tests equals the number of `SummaryKind` cases.
     
     Someday I will make it so that it will be possible to check how correctly the values are mathematically calculated, but so far so
     */
    func testComputingPercentOfSetGoals() throws {
        summary = Summary(icon: Icons.grid, title: Labels.Summary.percentOfSetGoals, tintColor: .systemTeal,
                          measure: "% \(Labels.Summary.ofSetGoals)", kind: .percentOfSetGoals,
                          description: Labels.Charts.percentOfSetGoalsDescription, isLessBetter: false, competion: { months in
            var result = [(String, Double)]()
            var totalSumOfCompletedGoals = 0
            var totalSumOfGoals = 0
            
            for month in months {
                var tempAverage = 0.0
                guard let goals = month.goals?.array as? [Goal] else {
                    return .failure(SummaryKind.percentOfSetGoals)
                }
                totalSumOfGoals += goals.count
                goals.forEach { totalSumOfCompletedGoals += $0.current >= $0.aim ? 1 : 0 }
                
                tempAverage = round(100 * Double(totalSumOfCompletedGoals) / Double(totalSumOfGoals))
                result.append((month.date.formatTo("MMM YY"), tempAverage))
            }
            return .success(result)
        })
        interactor.computeData(by: summary)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
    
    func testComputingCompletedGoals() throws {
        summary = Summary(icon: Icons.checkmark, title: Labels.Summary.completedGoals, tintColor: .systemGreen,
                          measure: Labels.Summary.goalsDeclension, kind: .completedGoals,
                          description: Labels.Charts.completedGoalsDescription, isLessBetter: false, competion: { months in
            var result = [(String, Double)]()
            
            for month in months {
                var temp = 0.0
                guard let goals = month.goals?.array as? [Goal] else {
                    return .failure(SummaryKind.completedGoals)
                }
                goals.forEach { temp += $0.current >= $0.aim ? 1 : 0 }
                result.append((month.date.formatTo("MMM YY"), temp))
            }
            return .success(result)
        })
        interactor.computeData(by: summary)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
    
    func testComputingUncompletedGoals() throws {
        summary = Summary(icon: Icons.xmark, title: Labels.Summary.uncompletedGoals, tintColor: .systemRed,
                          measure: Labels.Summary.goalsDeclension, kind: .uncompletedGoals,
                          description: Labels.Charts.uncompletedGoalsDescription, isLessBetter: true, competion: { months in
            var result = [(String, Double)]()
            
            for month in months {
                var temp = 0.0
                guard let goals = month.goals?.array as? [Goal] else {
                    return .failure(SummaryKind.uncompletedGoals)
                }
                goals.forEach { temp += $0.current < $0.aim ? 1 : 0 }
                result.append((month.date.formatTo("MMM YY"), temp))
            }
            return .success(result)
        })
        interactor.computeData(by: summary)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
    
    func testComputingAllGoals() throws {
        summary = Summary(icon: Icons.sum, title: Labels.Summary.allGoals, tintColor: .systemOrange,
                          measure: Labels.Summary.goalsDeclension, kind: .allGoals,
                          description: Labels.Charts.allGoalsDescription, isLessBetter: false, competion: { months in
            var result = [(String, Double)]()
            var tempAllGoalsCounter = 0.0
            
            for month in months {
                tempAllGoalsCounter = tempAllGoalsCounter + Double(month.goals?.count ?? 0)
                result.append((month.date.formatTo("MMM YY"), tempAllGoalsCounter))
            }
            return .success(result)
        })
        interactor.computeData(by: summary)
        
        XCTAssertFalse(presenter.dataDidNotComputeBool)
        XCTAssertNotNil(presenter.data, "Provided data from Interactor should not be nil")
    }
}
