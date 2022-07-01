//
//  AgendaPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  

import Foundation

final class AgendaPresenter {
    weak var view: AgendaViewInput?
    weak var moduleOutput: AgendaModuleOutput?
    
    private let router: AgendaRouterInput
    private let interactor: AgendaInteractorInput
    
    init(router: AgendaRouterInput, interactor: AgendaInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AgendaPresenter: AgendaModuleInput {
}

extension AgendaPresenter: AgendaViewOutput {
    func fetchData() {
        interactor.fetchMonthGoals()
    }
    
    func addNewGoal() {
        interactor.provideDataForAdding()
    }
    
    func checkForOnboarding() {
        interactor.checkForOnboarding()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        interactor.getGoal(at: indexPath)
    }
    
    func moveRow(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        interactor.replaceGoal(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        interactor.deleteItem(at: indexPath)
    }
}

extension AgendaPresenter: AgendaInteractorOutput {
    func monthDidFetch(viewModels: [GoalViewModel], monthInfo: DateViewModel, date: String) {
        DispatchQueue.main.async { [unowned self] in
            view?.setMonthData(viewModels: viewModels, monthInfo: monthInfo, title: date)
        }
    }
    
    func dataDidNotFetch() {
        view?.showAlert(title: Labels.oopsError, message: Labels.Agenda.unknownErrorDescription)
    }
    
    func showAddGoalModuleWith(month: Month, moduleDependency: CoreDataManagerProtocol) {
        router.showAddGoalModule(in: month, moduleDependency: moduleDependency)
    }
    
    func showDetailsModuleWith(goal: Goal, moduleDependency: CoreDataManagerProtocol) {
        router.showDetailsModule(by: goal, moduleDependency: moduleDependency)
    }
    
    func showOnboarding() {
        router.showOnboarding()
    }
}
