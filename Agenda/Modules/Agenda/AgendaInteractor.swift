//
//  AgendaInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//

import Foundation

final class AgendaInteractor {
    weak var output: AgendaInteractorOutput?
    
    public let coreDataManager: CoreDataManagerProtocol
    public var month: Month! // current month
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension AgendaInteractor: AgendaInteractorInput {
    func fetchMonthGoals() {
        if month == nil {
            self.month = coreDataManager.fetchCurrentMonth()
        }
        guard let goals = self.month.goals?.array as? [Goal] else {
            output?.dataDidNotFetch()
            return
        }
        output?.monthDidFetch(goals: goals, date: month.date.formatTo("MMMMy"))
    }
    
    func getGoalAt(_ indexPath: IndexPath) {
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else {
            output?.dataDidNotFetch()
            return
        }
        output?.showDetailsModuleWith(goal: goal, moduleDependency: coreDataManager)
    }
    
    func replaceGoal(from a: Int, to b: Int) {
        guard let goal = month.goals?.object(at: a) as? Goal else { return }
        coreDataManager.replaceGoal(goal, in: month, from: a, to: b)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
        coreDataManager.deleteGoal(goal: goal)
    }
    
    func provideDataForAdding() {
        output?.showAddGoalModuleWith(month: month, moduleDependency: coreDataManager)
    }
    
    func checkForOnboarding() {
        if !UserDefaults.standard.hasOnboarded {
            output?.showOnboarding()
        }
    }
}
