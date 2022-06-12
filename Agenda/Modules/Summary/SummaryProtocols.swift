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
    func setData(numbers: [Double])
}

protocol SummaryViewOutput: AnyObject {
    func fetchData()
}

protocol SummaryInteractorInput: AnyObject {
    func performFetch()
}

protocol SummaryInteractorOutput: AnyObject {
    func dataDidFetch(numbers: [Double])
    func dataDidNotFetch()
}

protocol SummaryRouterInput: AnyObject {
}
