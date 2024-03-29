//
//  AgendaProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//

import Foundation

protocol AgendaModuleInput {
    var moduleOutput: AgendaModuleOutput? { get }
}

protocol AgendaModuleOutput: AnyObject {
    func monthDetailsModuleDidFinish()
}

protocol AgendaViewInput: AnyObject {
    func setMonthData(viewModels: [GoalViewModel], monthInfo: DateViewModel, title: String)
    func showAlert(title: String, message: String)
}

protocol AgendaViewOutput: AnyObject {
    func fetchData()
    
    func addNewGoal()
    func checkForOnboarding()
    
    func didSelectRow(at indexPath: IndexPath)
    func moveRow(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func deleteItem(at indexPath: IndexPath)
}

protocol AgendaInteractorInput: AnyObject {
    func fetchMonthGoals()
    func getGoal(at indexPath: IndexPath)
    func replaceGoal(from a: Int, to b: Int)
    func deleteItem(at indexPath: IndexPath)
    
    func provideDataForAdding()
    func checkForOnboarding()
}

protocol AgendaInteractorOutput: AnyObject {
    func monthDidFetch(viewModels: [GoalViewModel], monthInfo: DateViewModel, date: String)
    func dataDidNotFetch()
    
    func showAddGoalModuleWith(month: Month, moduleDependency: CoreDataManagerProtocol)
    func showDetailsModuleWith(goal: Goal, moduleDependency: CoreDataManagerProtocol)
    func showOnboarding()
}

protocol AgendaRouterInput: AnyObject {
    func showAddGoalModule(in month: Month, moduleDependency: CoreDataManagerProtocol)
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol)
    func showOnboarding()
}
