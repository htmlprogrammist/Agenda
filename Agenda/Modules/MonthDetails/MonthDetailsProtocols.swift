//
//  MonthDetailsProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

protocol MonthDetailsModuleInput {
    var moduleOutput: MonthDetailsModuleOutput? { get }
}

protocol MonthDetailsModuleOutput: AnyObject {
    func monthDetailsModuleDidFinish()
}

protocol MonthDetailsViewInput: AnyObject {
    func setMonthData(viewModels: [GoalViewModel], title: String)
}

protocol MonthDetailsViewOutput: AnyObject {
    func viewDidLoad()
    
    func didSelectRowAt(_ indexPath: IndexPath)
    func moveRowAt(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func deleteItem(at indexPath: IndexPath)
}

protocol MonthDetailsInteractorInput: AnyObject {
    var coreDataManager: CoreDataManagerProtocol { get }
    
    func replaceGoal(_ goal: Goal, in month: Month, from a: Int, to b: Int)
    func deleteGoal(_ goal: Goal)
}

protocol MonthDetailsInteractorOutput: AnyObject {
}

protocol MonthDetailsRouterInput: AnyObject {
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol)
}
