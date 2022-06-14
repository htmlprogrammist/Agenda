//
//  AgendaInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//

import Foundation

final class AgendaInteractor {
    weak var output: AgendaInteractorOutput?
    
    private let coreDataManager: CoreDataManagerProtocol
    
    public var month: Month! // current (Agenda) or selected (MonthDetails) month
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension AgendaInteractor: AgendaInteractorInput {
    func fetchMonthGoals() {
        if month == nil { // if month was not provided (e.g. in Agenda module)
            self.month = coreDataManager.fetchCurrentMonth()
        }
        guard let goals = month.goals?.array as? [Goal] else {
            output?.dataDidNotFetch()
            return
        }
        output?.monthDidFetch(viewModels: makeViewModels(goals), monthInfo: getMonthInfo(), date: month.date.formatTo("MMMMy"))
    }
    
    func getGoal(at indexPath: IndexPath) {
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else {
            output?.dataDidNotFetch()
            return
        }
        output?.showDetailsModuleWith(goal: goal, moduleDependency: coreDataManager)
    }
    
    func replaceGoal(from a: Int, to b: Int) {
        guard let goal = month.goals?.object(at: a) as? Goal else {
            output?.dataDidNotFetch()
            return
        }
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.coreDataManager.replaceGoal(goal, in: strongSelf.month, from: a, to: b)
        }
    }
    
    func deleteItem(at indexPath: IndexPath) {
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else {
            output?.dataDidNotFetch()
            return
        }
        DispatchQueue.global(qos: .utility).async { [weak coreDataManager] in
            coreDataManager?.deleteGoal(goal: goal)
        }
    }
    
    func provideDataForAdding() {
        output?.showAddGoalModuleWith(month: month, moduleDependency: coreDataManager)
    }
    
    func checkForOnboarding() {
        let settings = UserSettings()
        if let hasOnboarded = settings.hasOnboarded, !hasOnboarded {
            output?.showOnboarding()
        }
    }
}

// MARK: - Helper methods
private extension AgendaInteractor {
    func getMonthInfo() -> DateViewModel {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d")
        
        let calendar = Calendar.current
        let days = calendar.range(of: .day, in: .month, for: date)!.count // all days in current month
        
        return DateViewModel(dayAndMonth: dateFormatter.string(from: date),
                             year: calendar.dateComponents([.year], from: date).year ?? 0,
                             progress: Float(calendar.dateComponents([.day], from: date).day!) / Float(days))
    }
    
    func makeViewModels(_ goals: [Goal]) -> [GoalViewModel] {
        return goals.map { goal in
            GoalViewModel(name: goal.name, current: Int(goal.current), aim: Int(goal.aim))
        }
    }
}
