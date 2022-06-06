//
//  HistoryProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

protocol HistoryModuleInput {
    var moduleOutput: HistoryModuleOutput? { get }
}

protocol HistoryModuleOutput: AnyObject {
}

protocol HistoryViewInput: AnyObject {
    func showAlert(title: String, message: String)
    
    func setData(viewModels: [MonthViewModel])
}

protocol HistoryViewOutput: AnyObject {
    func fetchData()
    
    func didSelectRowAt(_ indexPath: IndexPath)
    func deleteItem(at indexPath: IndexPath)
}

protocol HistoryInteractorInput: AnyObject {
    var coreDataManager: CoreDataManagerProtocol { get }
    
    func performFetch()
    func deleteMonth(_ month: Month)
}

protocol HistoryInteractorOutput: AnyObject {
    func dataDidFetch(months: [Month])
    func dataDidNotFetch()
}

protocol HistoryRouterInput: AnyObject {
    func showMonthDetailsModule(month: Month, moduleDependency: CoreDataManagerProtocol)
}
