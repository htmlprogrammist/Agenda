//
//  SummaryContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import UIKit

final class SummaryContainer {
    let input: SummaryModuleInput
    let viewController: UIViewController
    private(set) weak var router: SummaryRouterInput!
    
    static func assemble(with context: SummaryContext) -> SummaryContainer {
        let router = SummaryRouter()
        let interactor = SummaryInteractor(coreDataManager: context.moduleDependency)
        let presenter = SummaryPresenter(router: router, interactor: interactor)
        let viewController = SummaryViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return SummaryContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SummaryModuleInput, router: SummaryRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SummaryContext {
    typealias ModuleDependency = CoreDataManagerProtocol
    
    weak var moduleOutput: SummaryModuleOutput?
    let moduleDependency: ModuleDependency
}
