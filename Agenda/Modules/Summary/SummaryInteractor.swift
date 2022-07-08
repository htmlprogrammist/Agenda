//
//  SummaryInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class SummaryInteractor {
    weak var output: SummaryInteractorOutput?
    
    private let settings = UserSettings()
    public let coreDataManager: CoreDataManagerProtocol
    
    /// This array describes what kind of data will be displayed in cells. User selects the data he needs and then we add/remove these `SummaryCell` enum's cases
    public lazy var cells: [SummaryKind] = settings.summaries?.compactMap { SummaryKind(rawValue: $0) } ?? [.percentOfSetGoals, .completedGoals, .uncompletedGoals, .allGoals]
    
    /// All summary data that could be in the application
    public var summaries: [Summary] = [
        Summary(icon: Icons.grid, title: Labels.Summary.percentOfSetGoals, tintColor: .systemTeal, measure: "% \(Labels.Summary.ofSetGoals)",
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
            }
        ),
        Summary(icon: Icons.checkmark, title: Labels.Summary.completedGoals, tintColor: .systemGreen, measure: Labels.Summary.goalsDeclension,
                kind: .completedGoals, description: Labels.Charts.completedGoalsDescription, isLessBetter: false, competion: { months in
                var result = [(String, Double)]()
                
                for month in months {
                    var temp = 0.0
                    guard let goals = month.goals?.array as? [Goal] else {
                        return .failure(NSError(domain: "", code: 5, userInfo: [NSLocalizedDescriptionKey: "Invalid `goals` value"]))
                    }
                    goals.forEach { temp += $0.current >= $0.aim ? 1 : 0 }
                    result.append((month.date.formatTo("MMM YY"), temp))
                }
                return .success(result)
            }
        ),
        Summary(icon: Icons.xmark, title: Labels.Summary.uncompletedGoals, tintColor: .systemRed, measure: Labels.Summary.goalsDeclension,
                kind: .uncompletedGoals, description: Labels.Charts.uncompletedGoalsDescription, isLessBetter: true, competion: { months in
                var result = [(String, Double)]()
                
                for month in months {
                    var temp = 0.0
                    guard let goals = month.goals?.array as? [Goal] else {
                        return .failure(NSError(domain: "", code: 5, userInfo: [NSLocalizedDescriptionKey: "Invalid `goals` value"]))
                    }
                    goals.forEach { temp += $0.current < $0.aim ? 1 : 0 }
                    result.append((month.date.formatTo("MMM YY"), temp))
                }
                return .success(result)
            }
        ),
        Summary(icon: Icons.sum, title: Labels.Summary.allGoals, tintColor: .systemOrange, measure: Labels.Summary.goalsDeclension,
                kind: .allGoals, description: Labels.Charts.allGoalsDescription, isLessBetter: false, competion: { months in
                var result = [(String, Double)]()
                var tempAllGoalsCounter = 0.0
                
                for month in months {
                    tempAllGoalsCounter = tempAllGoalsCounter + Double(month.goals?.count ?? 0)
                    result.append((month.date.formatTo("MMM YY"), tempAllGoalsCounter))
                }
                return .success(result)
            }
        )
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
            
            let summaries = strongSelf.summaries.filter { summary in
                strongSelf.cells.contains(summary.kind)
            }
            strongSelf.output?.dataDidFetch(data: summaries)
        }
    }
    
    func provideDataForCharts(data: Summary) {
        guard let months = coreDataManager.fetchMonths() else {
            output?.dataDidNotFetch()
            return
        }
        output?.provideDataForChartsModule(data: data, months: months)
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
        summaries[SummaryKind.percentOfSetGoals.rawValue].number = percentage
        summaries[SummaryKind.completedGoals.rawValue].number = completedGoalsCounter
        summaries[SummaryKind.uncompletedGoals.rawValue].number = uncompletedGoalsCounter
        summaries[SummaryKind.allGoals.rawValue].number = allGoalsCounter
    }
}
