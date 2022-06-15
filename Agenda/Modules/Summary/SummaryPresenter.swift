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
    
    /// This array describes what kind of data will be displayed in cells. User selects the data he needs and then we add/remove these `SummaryCell` enum's cases
    public var cells: [SummaryCell] = [.percentOfSetGoals, .completedGoals, .uncompletedGoals, .allGoals]
    
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
        // TODO: Presenter is now deciding, what kind of data will be displayed in View
//        let summaries = data.map { index in
            // нужно пройтись по массиву, и чей индекс совпадает, тот попадает в `summaries`
//        }
//        let summaries = data.filter { [unowned self] summary in
//            cells.contains(<#T##element: SummaryCell##SummaryCell#>) // 1
//            summaries.firstIndex(of: summary) == cells[i] // 2
//        }
        
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.setData(summaries: data)
        }
    }
    
    func dataDidNotFetch() {
        view?.showAlert(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
    }
}
