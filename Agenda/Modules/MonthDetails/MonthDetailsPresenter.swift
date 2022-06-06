//
//  MonthDetailsPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class MonthDetailsPresenter {
    weak var view: MonthDetailsViewInput?
    weak var moduleOutput: MonthDetailsModuleOutput?
    
    private let router: MonthDetailsRouterInput
    private let interactor: MonthDetailsInteractorInput
    
    public var month: Month!
    
    init(router: MonthDetailsRouterInput, interactor: MonthDetailsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MonthDetailsPresenter: MonthDetailsModuleInput {
}

extension MonthDetailsPresenter: MonthDetailsViewOutput {
    func viewDidLoad() {
        guard let goals = month.goals?.array as? [Goal] else {
            fatalError("Error at AgendaPresenter/monthDidFetch, goals in month are not [Goal] type")
        }
        view?.setMonthData(viewModels: makeViewModels(goals), title: month.date.formatTo("MMMMy"))
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
        router.showDetailsModule(by: goal, moduleDependency: interactor.coreDataManager)
    }
    
    func moveRowAt(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let chosenGoal = month.goals?.object(at: sourceIndexPath.row) as? Goal else { return }
        interactor.replaceGoal(chosenGoal, in: month, from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
        interactor.deleteGoal(goal)
    }
}

extension MonthDetailsPresenter: MonthDetailsInteractorOutput {
}

private extension MonthDetailsPresenter {
    func makeViewModels(_ goals: [Goal]) -> [GoalViewModel] {
        return goals.map { goal in
            GoalViewModel(name: goal.name, current: Int(goal.current), aim: Int(goal.aim))
        }
    }
}
