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
        interactor.didSelectRowAt(indexPath)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        interactor.deleteMonth(at: indexPath)
    }
}

extension HistoryPresenter: HistoryInteractorOutput {
    func dataDidFetch(months: [Month]) {
        view?.setData(viewModels: makeViewModels(months))
    }
    
    func dataDidNotFetch() {
        view?.showAlert(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
    }
    
    func showMonthDetailsModule(month: Month, moduleDependency: CoreDataManagerProtocol) {
        router.showMonthDetailsModule(month: month, moduleDependency: moduleDependency)
    }
}

private extension HistoryPresenter {
    func makeViewModels(_ months: [Month]) -> [MonthViewModel] {
        return months.map { MonthViewModel(month: $0) }
    }
}
