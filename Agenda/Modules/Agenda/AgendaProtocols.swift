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
}

// Описывает то, как мы на вью отображаем какие-то элекменты (например, говорим View: "Покажи картинку")
// Presenter имеет ссылку на View (1a/2)
protocol AgendaViewInput: AnyObject {
    func setMonthData(viewModels: [GoalViewModel], monthInfo: DateViewModel)
}

// Перечисление тех событий, которые могут прийти ИЗ View (например, пользователь нажал на кнопку создания аккаунта)
// При этом Presenter так же реализует протокол output, потому что он обрабаывает события ОТ View (2a/2)
protocol AgendaViewOutput: AnyObject {
    func viewDidLoad()
    
    func addNewGoal()
    func showOnboarding()
    
    func didSelectRowAt(_ indexPath: IndexPath)
    func moveRowAt(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func deleteGoal(at indexPath: IndexPath)
}

// Presenter через протокол говорит Interactor'у, что надо создать аккаунт (1b/2)
protocol AgendaInteractorInput: AnyObject {
    var coreDataManager: CoreDataManagerProtocol { get }
    
    func fetchCurrentMonth()
    func replaceGoal(_ goal: Goal, in month: Month, from a: Int, to b: Int)
    func deleteGoal(_ goal: Goal)
}

// Interactor говорит Presenter'у, что аккаунт был создан и передаёт какие-то данные (2b/2)
protocol AgendaInteractorOutput: AnyObject {
    func monthDidFetch(month: Month)
}

protocol AgendaRouterInput: AnyObject {
    func showAddGoalModule(in month: Month, moduleDependency: CoreDataManagerProtocol)
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol)
    func showOnboarding()
}
