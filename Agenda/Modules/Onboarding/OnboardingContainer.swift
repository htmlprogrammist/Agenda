//
//  OnboardingContainer.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.06.2022.
//  

import UIKit

final class OnboardingContainer {
    let input: OnboardingModuleInput
    let viewController: UIViewController
    private(set) weak var router: OnboardingRouterInput!
    
    static func assemble(with context: OnboardingContext) -> OnboardingContainer {
        let router = OnboardingRouter()
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter(router: router, interactor: interactor)
        let viewController = OnboardingViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return OnboardingContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: OnboardingModuleInput, router: OnboardingRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct OnboardingContext {
    weak var moduleOutput: OnboardingModuleOutput?
}
