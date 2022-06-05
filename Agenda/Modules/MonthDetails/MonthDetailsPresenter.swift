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
    
    init(router: MonthDetailsRouterInput, interactor: MonthDetailsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MonthDetailsPresenter: MonthDetailsModuleInput {
}

extension MonthDetailsPresenter: MonthDetailsViewOutput {
}

extension MonthDetailsPresenter: MonthDetailsInteractorOutput {
}
