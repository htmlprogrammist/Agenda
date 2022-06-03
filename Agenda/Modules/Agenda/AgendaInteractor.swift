//
//  AgendaInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  
//

import Foundation

// Какой-то use-case (какое-то действие, например: создать аккаунт)
final class AgendaInteractor {
    weak var output: AgendaInteractorOutput?
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension AgendaInteractor: AgendaInteractorInput {
    func fetchCurrentMonth() {
        let month = coreDataManager.fetchCurrentMonth()
        output?.monthDidFetch(month: month)
    }
    
    func replaceGoal(_ goal: Goal, in month: Month, from a: Int, to b: Int) {
        coreDataManager.replaceGoal(goal, in: month, from: a, to: b)
    }
    
    func deleteGoal(_ goal: Goal) {
        coreDataManager.deleteGoal(goal: goal)
    }
}
