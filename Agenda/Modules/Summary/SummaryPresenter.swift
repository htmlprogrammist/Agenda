//
//  SummaryPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class SummaryPresenter {
    weak var view: SummaryViewInput?
    weak var moduleOutput: SummaryModuleOutput?
    
    private let router: SummaryRouterInput
    private let interactor: SummaryInteractorInput
    
    init(router: SummaryRouterInput, interactor: SummaryInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SummaryPresenter: SummaryModuleInput {
}

extension SummaryPresenter: SummaryViewOutput {
    func fetchData() {
        interactor.performFetch()
    }
}

extension SummaryPresenter: SummaryInteractorOutput {
    func dataDidFetch(data: [Summary]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setData(summaries: data)
        }
    }
    
    func dataDidNotFetch() {
        view?.showAlert(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
    }
}
