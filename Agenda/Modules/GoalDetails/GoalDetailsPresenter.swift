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
    
    init(router: GoalDetailsRouterInput, interactor: GoalDetailsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension GoalDetailsPresenter: GoalDetailsModuleInput {
}

extension GoalDetailsPresenter: GoalDetailsViewOutput {
    func viewDidLoad() {
        interactor.provideData()
    }
    
    func saveButtonTapped(data: GoalData) {
        interactor.rewriteGoal(with: data)
    }
    
    func checkBarButtonEnabled(goalData: GoalData) {
        interactor.checkBarButtonEnabled(goalData: goalData)
    }
}

extension GoalDetailsPresenter: GoalDetailsInteractorOutput {
    func goalDidRewrite() {
        view?.presentSuccess()
    }
    
    func goalDidLoad(goalData: GoalData) {
        view?.setViewModel(goalData: goalData)
    }
    
    func barButtonDidCheck(with flag: Bool) {
        view?.updateBarButton(with: flag)
    }
}
