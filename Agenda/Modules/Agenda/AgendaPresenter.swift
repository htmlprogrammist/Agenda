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

// MARK: - View
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
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        interactor.getGoalAt(indexPath)
    }
    
    func moveRowAt(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        interactor.replaceGoal(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        interactor.deleteItem(at: indexPath)
    }
}

extension AgendaPresenter: AgendaInteractorOutput {
    func monthDidFetch(goals: [Goal], date: String) {
        view?.setMonthData(viewModels: makeViewModels(goals), monthInfo: getMonthInfo(), title: date)
    }
    
    func dataDidNotFetch() {
        view?.showAlert(title: Labels.oopsError, message: Labels.Summary.fetchErrorDescription)
    }
    
    func monthDidProvide(month: Month) {
        router.showAddGoalModule(in: month, moduleDependency: interactor.coreDataManager)
    }
    
    func showAddGoalModuleWith(month: Month, moduleDependency: CoreDataManagerProtocol) {
        router.showAddGoalModule(in: month, moduleDependency: moduleDependency)
    }
    
    func showDetailsModuleWith(goal: Goal, moduleDependency: CoreDataManagerProtocol) {
        router.showDetailsModule(by: goal, moduleDependency: interactor.coreDataManager)
    }
    
    func showOnboarding() {
        router.showOnboarding()
    }
}

// MARK: - Methods
private extension AgendaPresenter {
    func getMonthInfo() -> DateViewModel {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d")
        
        let calendar = Calendar.current
        let days = calendar.range(of: .day, in: .month, for: date)!.count // all days in current month
        
        return DateViewModel(dayAndMonth: dateFormatter.string(from: date),
                             year: calendar.dateComponents([.year], from: date).year ?? 0,
                             progress: Float(calendar.dateComponents([.day], from: date).day!) / Float(days))
    }
    
    func makeViewModels(_ goals: [Goal]) -> [GoalViewModel] {
        return goals.map { goal in
            GoalViewModel(name: goal.name, current: Int(goal.current), aim: Int(goal.aim))
        }
    }
}
