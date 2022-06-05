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
}

protocol HistoryViewOutput: AnyObject {
    func viewDidLoad()
}

protocol HistoryInteractorInput: AnyObject {
    func performFetch()
}

protocol HistoryInteractorOutput: AnyObject {
    func dataDidFetch()
}

protocol HistoryRouterInput: AnyObject {
}
