//
//  GoalDetailsInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import Foundation

final class GoalDetailsInteractor {
    weak var output: GoalDetailsInteractorOutput?
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension GoalDetailsInteractor: GoalDetailsInteractorInput {
    func rewriteGoal(with data: GoalData, in goal: Goal) {
        coreDataManager.rewriteGoal(with: data, in: goal)
        output?.goalDidRewrite()
    }
}
