//
//  OnboardingInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.06.2022.
//  

import Foundation

final class OnboardingInteractor {
    weak var output: OnboardingInteractorOutput?
}

extension OnboardingInteractor: OnboardingInteractorInput {
    func setHasOnboarded() {
        var settings = UserSettings()
        settings.hasOnboarded = true
        output?.hasOnboardedDidSet()
        
        /// Set default what kind of summary data will be displayed to the user
        settings.summaries = [SummaryKind.percentOfSetGoals.rawValue, SummaryKind.completedGoals.rawValue, SummaryKind.uncompletedGoals.rawValue, SummaryKind.allGoals.rawValue]
    }
}
