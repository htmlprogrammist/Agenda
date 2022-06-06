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
}

protocol AgendaViewOutput: AnyObject {
    func fetchData()
    
    func addNewGoal()
    func showOnboarding()
    
    func didSelectRowAt(_ indexPath: IndexPath)
    func moveRowAt(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func deleteItem(at indexPath: IndexPath)
}

protocol AgendaInteractorInput: AnyObject {
    var coreDataManager: CoreDataManagerProtocol { get }
    
    func fetchCurrentMonth()
    func replaceGoal(_ goal: Goal, in month: Month, from a: Int, to b: Int)
    func deleteGoal(_ goal: Goal)
}

protocol AgendaInteractorOutput: AnyObject {
    func monthDidFetch(month: Month)
}

protocol AgendaRouterInput: AnyObject {
    func showAddGoalModule(in month: Month, moduleDependency: CoreDataManagerProtocol)
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol)
    func showOnboarding()
}
