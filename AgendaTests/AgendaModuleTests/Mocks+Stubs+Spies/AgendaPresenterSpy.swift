//
//  AgendaPresenterSpy.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 12.06.2022.
//

@testable import Agenda

class AgendaPresenterSpy: AgendaInteractorOutput {
    var viewModels: [GoalViewModel]?
    var monthInfo: DateViewModel?
    var date: String?
    
    var dataDidNotFetchBool = false
    var dependencyProvided: CoreDataManagerProtocol?
    var monthProvided: Month?
    var goalDidProvide = false
    var onboardingDidShow = false
    
    func monthDidFetch(viewModels: [GoalViewModel], monthInfo: DateViewModel, date: String) {
        self.viewModels = viewModels
        self.monthInfo = monthInfo
        self.date = date
    }
    
    func dataDidNotFetch() {
        dataDidNotFetchBool = true
    }
    
    func showAddGoalModuleWith(month: Month, moduleDependency: CoreDataManagerProtocol) {
        monthProvided = month
        dependencyProvided = moduleDependency
    }
    
    func showDetailsModuleWith(goal: Goal, moduleDependency: CoreDataManagerProtocol) {
        goalDidProvide = true
        dependencyProvided = moduleDependency
    }
    
    func showOnboarding() {
        onboardingDidShow = true
    }
}
