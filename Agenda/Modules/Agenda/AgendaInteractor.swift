//
//  AgendaInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  
//

import Foundation

// Какой-то use-case (какое-то действие, например: создать аккаунт)
final class AgendaInteractor {
	weak var output: AgendaInteractorOutput?
}

extension AgendaInteractor: AgendaInteractorInput {
}
