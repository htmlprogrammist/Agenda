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
    func setData(summaries: [Summary])
}

protocol SummaryViewOutput: AnyObject {
    func fetchData()
}

protocol SummaryInteractorInput: AnyObject {
    func performFetch()
}

protocol SummaryInteractorOutput: AnyObject {
    func dataDidFetch(data: [Summary])
    func dataDidNotFetch()
}

protocol SummaryRouterInput: AnyObject {
}
