//
//  AgendaRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  
//

import UIKit

final class AgendaRouter {
}

extension AgendaRouter: AgendaRouterInput {
    func showAddGoal() {
        let context = AddGoalContext(moduleOutput: self)
        let container = AddGoalContainer.assemble(with: context)
        let navController = UINavigationController(rootViewController: container.viewController)
//        navController.present(navController)
    }
    
    func showDetails() {
        let context = GoalDetailsContext(moduleOutput: self)
        let container = GoalDetailsContainer.assemble(with: context)
        let navController = UINavigationController(rootViewController: container.viewController)
    }
}

extension AgendaRouter: AddGoalModuleOutput {
}

extension AgendaRouter: GoalDetailsModuleOutput {
}
