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
    
    private var month: Month! // current month
    
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
        interactor.fetchCurrentMonth()
    }
    
    func addNewGoal() {
        router.showAddGoalModule(in: month, moduleDependency: interactor.coreDataManager)
    }
    
    func showOnboarding() {
        router.showOnboarding()
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

extension AgendaPresenter: AgendaInteractorOutput {
    func monthDidFetch(month: Month) {
        self.month = month
        guard let goals = month.goals?.array as? [Goal] else {
            fatalError("Error at AgendaPresenter/monthDidFetch, goals in month are not [Goal] type")
        }
        view?.setMonthData(viewModels: makeViewModels(goals), monthInfo: getMonthInfo())
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
