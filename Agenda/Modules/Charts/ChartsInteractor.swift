//
//  ChartsInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  

import Foundation

final class ChartsInteractor {
    weak var output: ChartsInteractorOutput?
    
    private let months: [Month]
    
    init(months: [Month]) {
        self.months = months.reversed()
    }
}

extension ChartsInteractor: ChartsInteractorInput {
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

private extension ChartsInteractor {
    /// Computes the percantage of completed goals by months
    func computePercentOfSetGoals() {
        var result = [(String, Double)]()
        
        for i in 0..<months.count {
            var temp = 0.0
            // TODO: подсчитать количество достигаемых целей на тот период (то есть с первого месяца по i-тый)
            result.append((months[i].date.formatTo("MMMM"), temp))
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
            result.append((month.date.formatTo("MMMM"), temp))
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
            result.append((month.date.formatTo("MMMM"), temp))
        }
        
        output?.dataDidCompute(data: result)
    }
    
    /// Computes all setted goals by months
    func computeAllGoals() {
        var result = [(String, Double)]()
        var tempAllGoalsCounter = 0.0
        
        for month in months {
            tempAllGoalsCounter = tempAllGoalsCounter + Double(month.goals?.count ?? 0)
            result.append((month.date.formatTo("MMMM"), tempAllGoalsCounter))
        }
        
        output?.dataDidCompute(data: result)
    }
}
