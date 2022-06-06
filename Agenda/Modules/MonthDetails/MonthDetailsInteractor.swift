//
//  MonthDetailsInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class MonthDetailsInteractor {
    weak var output: MonthDetailsInteractorOutput?
    
    public let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension MonthDetailsInteractor: MonthDetailsInteractorInput {
    func replaceGoal(_ goal: Goal, in month: Month, from a: Int, to b: Int) {
        coreDataManager.replaceGoal(goal, in: month, from: a, to: b)
    }
    
    func deleteGoal(_ goal: Goal) {
        coreDataManager.deleteGoal(goal: goal)
    }
}
