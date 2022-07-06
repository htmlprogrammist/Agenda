//
//  ChartsContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  

import UIKit

final class ChartsContainer {
    let input: ChartsModuleInput
    let viewController: UIViewController
    private(set) weak var router: ChartsRouterInput!
    
    static func assemble(with context: ChartsContext) -> ChartsContainer {
        let router = ChartsRouter()
        let interactor = ChartsInteractor(months: context.months)
        let presenter = ChartsPresenter(router: router, interactor: interactor)
        let viewController = ChartsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        viewController.summary = context.data
        
        return ChartsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ChartsModuleInput, router: ChartsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ChartsContext {
    weak var moduleOutput: ChartsModuleOutput?
    var data: Summary
    var months: [Month]
}
