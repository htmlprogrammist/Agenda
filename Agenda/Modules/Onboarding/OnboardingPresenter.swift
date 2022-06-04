//
//  OnboardingPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.06.2022.
//  
//

import Foundation

final class OnboardingPresenter {
    weak var view: OnboardingViewInput?
    weak var moduleOutput: OnboardingModuleOutput?
    
    private let router: OnboardingRouterInput
    private let interactor: OnboardingInteractorInput
    
    init(router: OnboardingRouterInput, interactor: OnboardingInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension OnboardingPresenter: OnboardingModuleInput {
}

extension OnboardingPresenter: OnboardingViewOutput {
    func continueButtonTapped() {
        UserDefaults.standard.hasOnboarded = true
        moduleOutput?.onboardingModuleDidFinish()
    }
}

extension OnboardingPresenter: OnboardingInteractorOutput {
}
