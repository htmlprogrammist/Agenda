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
    /// Chosen goal to change the data in
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
        output?.goalDidRewrite()
        
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            coreDataManager.updateGoal(with: data, in: goal)
        }
    }
    
    func checkBarButtonEnabled(goalData: GoalData) {
        if !goalData.title.isEmpty, !goalData.current.isEmpty, !goalData.aim.isEmpty,
            (goalData.title != goal.name || goalData.current != String(goal.current) ||
             goalData.aim != String(goal.aim) || goalData.notes != goal.notes) {
            output?.barButtonDidCheck(with: true)
        } else {
            output?.barButtonDidCheck(with: false)
        }
    }
}
