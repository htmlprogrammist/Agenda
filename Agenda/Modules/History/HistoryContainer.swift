//
//  HistoryContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  
//

import UIKit

final class HistoryContainer {
    let input: HistoryModuleInput
    let viewController: UIViewController
    private(set) weak var router: HistoryRouterInput!
    
    static func assemble(with context: HistoryContext) -> HistoryContainer {
        let router = HistoryRouter()
        let interactor = HistoryInteractor()
        let presenter = HistoryPresenter(router: router, interactor: interactor)
        let viewController = HistoryViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return HistoryContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: HistoryModuleInput, router: HistoryRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct HistoryContext {
    typealias ModuleDependency = CoreDataManagerProtocol
    
    weak var moduleOutput: HistoryModuleOutput?
    let moduleDependency: ModuleDependency
}
