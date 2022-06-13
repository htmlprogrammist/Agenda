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
    
    public var month: Month!
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension AddGoalInteractor: AddGoalInteractorInput {
    func createGoal(goalData: GoalData) {
        output?.goalDidCreate()
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            self.coreDataManager.createGoal(data: goalData, in: self.month)
        }
    }
}
