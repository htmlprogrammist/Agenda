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
    
    func didSelectRow(with data: Summary)
}

protocol SummaryInteractorInput: AnyObject {
    func performFetch()
    func provideDataForCharts(data: Summary)
}

protocol SummaryInteractorOutput: AnyObject {
    func dataDidFetch(data: [Summary])
    func dataDidNotFetch()
    func provideDataForChartsModule(data: Summary, months: [Month])
}

protocol SummaryRouterInput: AnyObject {
    func openChartsModuleWith(data: Summary, months: [Month])
}
