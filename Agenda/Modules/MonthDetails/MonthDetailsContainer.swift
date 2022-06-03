//
//  MonthDetailsContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  
//

import UIKit

final class MonthDetailsContainer {
    let input: MonthDetailsModuleInput
    let viewController: UIViewController
    private(set) weak var router: MonthDetailsRouterInput!
    
    static func assemble(with context: MonthDetailsContext) -> MonthDetailsContainer {
        let router = MonthDetailsRouter()
        let interactor = MonthDetailsInteractor()
        let presenter = MonthDetailsPresenter(router: router, interactor: interactor)
        let viewController = MonthDetailsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return MonthDetailsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: MonthDetailsModuleInput, router: MonthDetailsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct MonthDetailsContext {
    weak var moduleOutput: MonthDetailsModuleOutput?
}
