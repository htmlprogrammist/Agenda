//
//  AddGoalContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import UIKit

final class AddGoalContainer {
    let input: AddGoalModuleInput
    let viewController: UIViewController
    private(set) weak var router: AddGoalRouterInput!
    
    static func assemble(with context: AddGoalContext) -> AddGoalContainer {
        let router = AddGoalRouter()
        let interactor = AddGoalInteractor(coreDataManager: context.moduleDependency)
        let presenter = AddGoalPresenter(router: router, interactor: interactor)
        let viewController = AddGoalViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        presenter.month = context.month
        
        interactor.output = presenter
        
        return AddGoalContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: AddGoalModuleInput, router: AddGoalRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct AddGoalContext {
    typealias ModuleDependency = CoreDataManagerProtocol
    
    weak var moduleOutput: AddGoalModuleOutput?
    let moduleDependency: ModuleDependency
    let month: Month
}
