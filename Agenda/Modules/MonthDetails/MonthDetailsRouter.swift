//
//  MonthDetailsRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import UIKit

final class MonthDetailsRouter: BaseRouter {
}

extension MonthDetailsRouter: MonthDetailsRouterInput {
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol) {
        let context = GoalDetailsContext(moduleOutput: self, moduleDependency: moduleDependency, goal: goal)
        let container = GoalDetailsContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension MonthDetailsRouter: GoalDetailsModuleOutput {
    func goalDetailsModuleDidFinish() {
        navigationController?.dismiss(animated: true)
    }
}
