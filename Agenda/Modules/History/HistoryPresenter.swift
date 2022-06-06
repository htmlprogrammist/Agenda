//
//  HistoryPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class HistoryPresenter {
    weak var view: HistoryViewInput?
    weak var moduleOutput: HistoryModuleOutput?
    
    private let router: HistoryRouterInput
    private let interactor: HistoryInteractorInput
    
    private var months = [Month]()
    
    init(router: HistoryRouterInput, interactor: HistoryInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HistoryPresenter: HistoryModuleInput {
}

extension HistoryPresenter: HistoryViewOutput {
    func fetchData() {
        interactor.performFetch()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let month = months[indexPath.row]
        router.showMonthDetailsModule(month: month, moduleDependency: interactor.coreDataManager)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        let month = months[indexPath.row]
        interactor.deleteMonth(month)
    }
}

extension HistoryPresenter: HistoryInteractorOutput {
    func dataDidFetch(months: [Month]) {
        self.months = months
        view?.setData(viewModels: makeViewModels(months))
    }
    
    func dataDidNotFetch() {
        view?.showAlert(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
    }
}

private extension HistoryPresenter {
    func makeViewModels(_ months: [Month]) -> [MonthViewModel] {
        return months.map { MonthViewModel(month: $0) }
    }
}
