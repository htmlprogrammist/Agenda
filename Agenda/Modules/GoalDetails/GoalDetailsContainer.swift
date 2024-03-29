//
//  GoalDetailsContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import UIKit

final class GoalDetailsContainer {
    let input: GoalDetailsModuleInput
    let viewController: UIViewController
    private(set) weak var router: GoalDetailsRouterInput!
    
    static func assemble(with context: GoalDetailsContext) -> GoalDetailsContainer {
        let router = GoalDetailsRouter()
        let interactor = GoalDetailsInteractor(coreDataManager: context.moduleDependency)
        let presenter = GoalDetailsPresenter(router: router, interactor: interactor)
        let viewController = GoalDetailsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        interactor.goal = context.goal
        
        return GoalDetailsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: GoalDetailsModuleInput, router: GoalDetailsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct GoalDetailsContext {
    typealias ModuleDependency = CoreDataManagerProtocol
    
    weak var moduleOutput: GoalDetailsModuleOutput?
    let moduleDependency: ModuleDependency
    let goal: Goal
}
