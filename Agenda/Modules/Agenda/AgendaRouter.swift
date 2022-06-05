//
//  AgendaRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  

import UIKit

final class AgendaRouter: BaseRouter {
}

extension AgendaRouter: AgendaRouterInput {
    func showAddGoalModule(in month: Month, moduleDependency: CoreDataManagerProtocol) {
        let context = AddGoalContext(moduleOutput: self, moduleDependency: moduleDependency, month: month)
        let container = AddGoalContainer.assemble(with: context)
        let navController = UINavigationController(rootViewController: container.viewController)
        navigationController?.present(navController, animated: true)
    }
    
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol) {
        let context = GoalDetailsContext(moduleOutput: self, moduleDependency: moduleDependency, goal: goal)
        let container = GoalDetailsContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
    
    func showOnboarding() {
        let context = OnboardingContext(moduleOutput: self)
        let container = OnboardingContainer.assemble(with: context)
        navigationController?.present(container.viewController, animated: true)
    }
}

extension AgendaRouter: AddGoalModuleOutput {
    func addGoalModuleDidFinish() {
        navigationController?.dismiss(animated: true)
    }
}

extension AgendaRouter: GoalDetailsModuleOutput {
}

extension AgendaRouter: OnboardingModuleOutput {
    func onboardingModuleDidFinish() {
        navigationController?.dismiss(animated: true)
    }
}
