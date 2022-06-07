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
    
    public var goal: Goal!
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension GoalDetailsInteractor: GoalDetailsInteractorInput {
    func provideData() {
        output?.goalDidLoad(goalData: goal.goalData)
    }
    
    func rewriteGoal(with data: GoalData) {
        coreDataManager.rewriteGoal(with: data, in: goal)
        output?.goalDidRewrite()
    }
    
    func checkBarButtonEnabled(goalData: GoalData) -> Bool {
        if !goalData.title.isEmpty, !goalData.current.isEmpty, !goalData.aim.isEmpty {
            if goalData.title != goal.name || goalData.current != String(goal.current) || goalData.aim != String(goal.aim) || goalData.notes != goal.notes {
                return true
            }
        }
        return false
    }
}
