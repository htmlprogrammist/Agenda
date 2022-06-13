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
    func deleteItemAt(_ indexPath: IndexPath)
}

protocol HistoryInteractorInput: AnyObject {
    func performFetch()
    func openDetailsByMonthAt(_ indexPath: IndexPath)
    func deleteMonthAt(_ indexPath: IndexPath)
}

protocol HistoryInteractorOutput: AnyObject {
    func dataDidFetch(viewModels: [MonthViewModel])
    func dataDidNotFetch()
    
    func showMonthDetailsModule(month: Month, moduleDependency: CoreDataManagerProtocol)
}

protocol HistoryRouterInput: AnyObject {
    func showMonthDetailsModule(month: Month, moduleDependency: CoreDataManagerProtocol)
}
