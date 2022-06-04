//
//  GoalDetailsPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  
//

import Foundation

final class GoalDetailsPresenter {
    
    public var goal: Goal!
    
    weak var view: GoalDetailsViewInput?
    weak var moduleOutput: GoalDetailsModuleOutput?
    
    private let router: GoalDetailsRouterInput
    private let interactor: GoalDetailsInteractorInput
    
    init(router: GoalDetailsRouterInput, interactor: GoalDetailsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension GoalDetailsPresenter: GoalDetailsModuleInput {
}

extension GoalDetailsPresenter: GoalDetailsViewOutput {
}

extension GoalDetailsPresenter: GoalDetailsInteractorOutput {
}
