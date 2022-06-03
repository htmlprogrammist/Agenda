//
//  HistoryPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  
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
}

extension HistoryPresenter: HistoryInteractorOutput {
}
