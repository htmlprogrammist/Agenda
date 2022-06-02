//
//  AgendaPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  
//

import Foundation

// 1. Отвечает за обработку событий пользователя, полученных от View
// 2. Также он решает какой экран нужно показать (передаёт Router'у события)
// 3. Может запросить данные у Interactor и показать во View
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

extension AgendaPresenter: AgendaViewOutput {
}

extension AgendaPresenter: AgendaInteractorOutput {
}
