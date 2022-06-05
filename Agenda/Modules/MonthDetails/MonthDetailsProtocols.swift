//
//  MonthDetailsProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

protocol MonthDetailsModuleInput {
    var moduleOutput: MonthDetailsModuleOutput? { get }
}

protocol MonthDetailsModuleOutput: AnyObject {
}

protocol MonthDetailsViewInput: AnyObject {
}

protocol MonthDetailsViewOutput: AnyObject {
}

protocol MonthDetailsInteractorInput: AnyObject {
}

protocol MonthDetailsInteractorOutput: AnyObject {
}

protocol MonthDetailsRouterInput: AnyObject {
}
