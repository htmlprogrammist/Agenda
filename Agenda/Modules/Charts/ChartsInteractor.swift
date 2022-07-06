//
//  ChartsInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  

import Foundation

final class ChartsInteractor {
    weak var output: ChartsInteractorOutput?
    
    /// Array of user's months history
    private let months: [Month]
    
    init(months: [Month]) {
        /// We need to reverse them to make the order be descending
        self.months = months.reversed()
    }
}

extension ChartsInteractor: ChartsInteractorInput {
    /// Method calls another method with computing data by provided `kind`
    /// - Parameter kind: kind of summary data
    func computeData(by kind: SummaryKind) {
        switch kind {
        case .percentOfSetGoals:
            computePercentOfSetGoals()
        case .completedGoals:
            computeCompletedGoals()
        case .uncompletedGoals:
            computeUncompletedGoals()
        case .allGoals:
            computeAllGoals()
        }
    }
}

// MARK: - Computing data methods
/// For every kind of summary data we need to implement method that prepares data for charts
private extension ChartsInteractor {
    /// Computes the percantage of completed goals by months
    func computePercentOfSetGoals() {
        var result = [(String, Double)]()
        var totalSumOfCompletedGoals = 0
        var totalSumOfGoals = 0
        
        for month in months {
            var tempAverage = 0.0
            guard let goals = month.goals?.array as? [Goal] else {
                output?.dataDidNotCompute()
                return
            }
            totalSumOfGoals += goals.count
            goals.forEach { totalSumOfCompletedGoals += $0.current >= $0.aim ? 1 : 0 }
            
            tempAverage = round(100 * Double(totalSumOfCompletedGoals) / Double(totalSumOfGoals))
            result.append((month.date.formatTo("MMM YY"), tempAverage))
        }
        output?.dataDidCompute(data: result)
    }
    
    /// Computes all completed goals by months
    func computeCompletedGoals() {
        var result = [(String, Double)]()
        
        for month in months {
            var temp = 0.0
            guard let goals = month.goals?.array as? [Goal] else {
                output?.dataDidNotCompute()
                return
            }
            goals.forEach { temp += $0.current >= $0.aim ? 1 : 0 }
            result.append((month.date.formatTo("MMM YY"), temp))
        }
        
        output?.dataDidCompute(data: result)
    }
    
    /// Computes all uncompleted goals by months
    func computeUncompletedGoals() {
        var result = [(String, Double)]()
        
        for month in months {
            var temp = 0.0
            guard let goals = month.goals?.array as? [Goal] else {
                output?.dataDidNotCompute()
                return
            }
            goals.forEach { temp += $0.current < $0.aim ? 1 : 0 }
            result.append((month.date.formatTo("MMM YY"), temp))
        }
        
        output?.dataDidCompute(data: result)
    }
    
    /// Computes all setted goals by months
    func computeAllGoals() {
        var result = [(String, Double)]()
        var tempAllGoalsCounter = 0.0
        
        for month in months {
            tempAllGoalsCounter = tempAllGoalsCounter + Double(month.goals?.count ?? 0)
            result.append((month.date.formatTo("MMM YY"), tempAllGoalsCounter))
        }
        
        output?.dataDidCompute(data: result)
    }
}
