//
//  AgendaContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  

import UIKit

final class AgendaContainer {
    let input: AgendaModuleInput
    let viewController: UIViewController
    private(set) weak var router: AgendaRouterInput!
    
    static func assemble(with context: AgendaContext) -> AgendaContainer {
        let router = AgendaRouter()
        let interactor = AgendaInteractor(coreDataManager: context.moduleDependency)
        let presenter = AgendaPresenter(router: router, interactor: interactor)
        let viewController = AgendaViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }
        
        return AgendaContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: AgendaModuleInput, router: AgendaRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct AgendaContext {
    typealias ModuleDependency = CoreDataManagerProtocol
    
    weak var moduleOutput: AgendaModuleOutput?
    let moduleDependency: ModuleDependency
}
