//
//  SummaryPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  
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
}

extension SummaryPresenter: SummaryInteractorOutput {
}
