//
//  HistoryProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  
//

import Foundation

protocol HistoryModuleInput {
    var moduleOutput: HistoryModuleOutput? { get }
}

protocol HistoryModuleOutput: AnyObject {
}

protocol HistoryViewInput: AnyObject {
}

protocol HistoryViewOutput: AnyObject {
}

protocol HistoryInteractorInput: AnyObject {
}

protocol HistoryInteractorOutput: AnyObject {
}

protocol HistoryRouterInput: AnyObject {
}
