//
//  AddGoalInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import Foundation

final class AddGoalInteractor {
    weak var output: AddGoalInteractorOutput?
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension AddGoalInteractor: AddGoalInteractorInput {
    func createGoal(goalData: GoalData, in month: Month) {
        coreDataManager.createGoal(data: goalData, in: month)
        output?.goalDidCreate()
    }
}
