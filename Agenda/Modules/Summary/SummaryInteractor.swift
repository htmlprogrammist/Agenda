//
//  SummaryInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

enum SummaryCell: Int {
    case percentOfSetGoals, completedGoals, uncompletedGoals, allGoals
}

final class SummaryInteractor {
    weak var output: SummaryInteractorOutput?
    
    public let coreDataManager: CoreDataManagerProtocol
    
    var summaries: [Summary] = [
        Summary(icon: Icons.grid, title: Labels.Summary.percentOfSetGoals, tintColor: .systemTeal, measure: "% \(Labels.Summary.ofSetGoals)"),
        Summary(icon: Icons.checkmark, title: Labels.Summary.completedGoals, tintColor: .systemGreen, measure: Labels.Summary.goalsDeclension),
        Summary(icon: Icons.xmark, title: Labels.Summary.uncompletedGoals, tintColor: .systemRed, measure: Labels.Summary.goalsDeclension),
        Summary(icon: Icons.sum, title: Labels.Summary.allGoals, tintColor: .systemOrange, measure: Labels.Summary.goalsDeclension)
    ]
    
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
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.countGoals(months: months)
            strongSelf.output?.dataDidFetch(data: strongSelf.summaries)
        }
    }
}

// MARK: - Helper methods
private extension SummaryInteractor {
    func countGoals(months: [Month]) {
        var completedGoalsCounter = 0.0
        var uncompletedGoalsCounter = 0.0
        var allGoalsCounter = 0.0
        var percentage = 0.0
        
        for month in months {
            guard let goals = month.goals?.array as? [Goal] else { return }
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
        summaries[SummaryCell.percentOfSetGoals.rawValue].number = percentage
        summaries[SummaryCell.completedGoals.rawValue].number = completedGoalsCounter
        summaries[SummaryCell.uncompletedGoals.rawValue].number = uncompletedGoalsCounter
        summaries[SummaryCell.allGoals.rawValue].number = allGoalsCounter
    }
}
