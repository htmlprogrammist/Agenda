//
//  AgendaContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  

import UIKit

/// This module is used as Agenda and MonthDetails (you will encounter this more than once).
/// Agenda is being created in AppCoordinator. MonthDetails is being called from the History module.
final class AgendaContainer {
    let input: AgendaModuleInput
    let viewController: UIViewController
    private(set) weak var router: AgendaRouterInput!
    
    static func assemble(with context: AgendaContext) -> AgendaContainer {
        let router = AgendaRouter()
        let interactor = AgendaInteractor(coreDataManager: context.moduleDependency)
        let presenter = AgendaPresenter(router: router, interactor: interactor)
        let viewController = AgendaViewController(output: presenter, isAgenda: context.month == nil)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        if let month = context.month {
            interactor.month = month
        }
        
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

/**
 For both modules, you need Core Data manager, but `month` and `moduleOutput` are being provided only in MonthDetails module.
 In Agenda you do not need to set these properties: month is fetched from the Core Data manager and it is shown in tab bar controller (no reason for providing output of the module
 */
struct AgendaContext {
    typealias ModuleDependency = CoreDataManagerProtocol
    
    weak var moduleOutput: AgendaModuleOutput?
    let moduleDependency: ModuleDependency
    var month: Month?
}
