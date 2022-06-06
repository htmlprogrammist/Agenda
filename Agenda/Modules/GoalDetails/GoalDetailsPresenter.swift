//
//  GoalDetailsPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import Foundation

final class GoalDetailsPresenter {
    weak var view: GoalDetailsViewInput?
    weak var moduleOutput: GoalDetailsModuleOutput?
    
    private let router: GoalDetailsRouterInput
    private let interactor: GoalDetailsInteractorInput
    
    public var goal: Goal!
    
    init(router: GoalDetailsRouterInput, interactor: GoalDetailsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension GoalDetailsPresenter: GoalDetailsModuleInput {
}

extension GoalDetailsPresenter: GoalDetailsViewOutput {
    func viewDidLoad() {
        view?.setViewModel(goalData: goal.goalData)
    }
    
    func saveButtonTapped(data: GoalData) {
        interactor.rewriteGoal(with: data, in: goal)
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

extension GoalDetailsPresenter: GoalDetailsInteractorOutput {
    func goalDidRewrite() {
        view?.presentSuccess()
    }
}
