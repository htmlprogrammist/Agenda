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
    /// Month in which new goal will be added
    public var month: Month!
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension AddGoalInteractor: AddGoalInteractorInput {
    func createGoal(goalData: GoalData) {
        output?.goalDidCreate()
        
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            coreDataManager.createGoal(data: goalData, in: month)
        }
    }
}
