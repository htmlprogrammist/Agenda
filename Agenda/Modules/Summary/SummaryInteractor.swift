//
//  SummaryInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class SummaryInteractor {
    weak var output: SummaryInteractorOutput?
    
    public let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension SummaryInteractor: SummaryInteractorInput {
    func performFetch() {
        guard let months = coreDataManager.fetchMonths() else {
            output?.dataDidNotFetch()
            return
        }
        output?.dataDidFetch(numbers: countGoals(months: months))
    }
}

// MARK: - Helper methods
private extension SummaryInteractor {
    func countGoals(months: [Month]) -> [Double] {
        var completedGoalsCounter = 0.0
        var uncompletedGoalsCounter = 0.0
        var allGoalsCounter = 0.0
        var percentage = 0.0
        
        for month in months {
            guard let goals = month.goals?.array as? [Goal] else {
                return []
            }
            for goal in goals {
                if goal.current >= goal.aim {
                    completedGoalsCounter += 1
                } else {
                    uncompletedGoalsCounter += 1
                }
                allGoalsCounter += 1
            }
            
            if allGoalsCounter > 0 {
                percentage = round(100 * Double(completedGoalsCounter) / Double(allGoalsCounter))
            }
        }
        return [percentage, completedGoalsCounter, uncompletedGoalsCounter, allGoalsCounter]
    }
}
