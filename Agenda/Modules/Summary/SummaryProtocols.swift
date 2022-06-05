//
//  SummaryProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

protocol SummaryModuleInput {
    var moduleOutput: SummaryModuleOutput? { get }
}

protocol SummaryModuleOutput: AnyObject {
}

protocol SummaryViewInput: AnyObject {
    func showAlert(title: String, message: String)
}

protocol SummaryViewOutput: AnyObject {
}

protocol SummaryInteractorInput: AnyObject {
}

protocol SummaryInteractorOutput: AnyObject {
}

protocol SummaryRouterInput: AnyObject {
}
