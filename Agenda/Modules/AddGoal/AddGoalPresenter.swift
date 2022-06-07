//
//  AddGoalPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//

import Foundation

final class AddGoalPresenter {
    weak var view: AddGoalViewInput?
    weak var moduleOutput: AddGoalModuleOutput?
    
    private let router: AddGoalRouterInput
    private let interactor: AddGoalInteractorInput
    
    init(router: AddGoalRouterInput, interactor: AddGoalInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AddGoalPresenter: AddGoalModuleInput {
}

extension AddGoalPresenter: AddGoalViewOutput {
    func doneButtonTapped(data: GoalData) {
        interactor.createGoal(goalData: data)
    }
    
    func closeThisModule() {
        moduleOutput?.addGoalModuleDidFinish()
    }
}

extension AddGoalPresenter: AddGoalInteractorOutput {
    func goalDidCreate() {
        moduleOutput?.addGoalModuleDidFinish()
    }
}
