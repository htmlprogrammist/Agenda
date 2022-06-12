//
//  AgendaRouterMock.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 12.06.2022.
//

@testable import Agenda

class AgendaRouterMock: AgendaRouterInput {
    func showAddGoalModule(in month: Month, moduleDependency: CoreDataManagerProtocol) {}
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol) {}
    func showOnboarding() {}
}
