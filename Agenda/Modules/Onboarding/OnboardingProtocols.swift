//
//  OnboardingProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.06.2022.
//  

import Foundation

protocol OnboardingModuleInput {
    var moduleOutput: OnboardingModuleOutput? { get }
}

protocol OnboardingModuleOutput: AnyObject {
    func onboardingModuleDidFinish()
}

protocol OnboardingViewInput: AnyObject {
}

protocol OnboardingViewOutput: AnyObject {
    func continueButtonTapped()
}

protocol OnboardingInteractorInput: AnyObject {
    func setHasOnboarded()
}

protocol OnboardingInteractorOutput: AnyObject {
    func hasOnboardedDidSet()
}

protocol OnboardingRouterInput: AnyObject {
}
