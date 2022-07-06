//
//  ChartsProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  

import Foundation

protocol ChartsModuleInput {
    var moduleOutput: ChartsModuleOutput? { get }
}

protocol ChartsModuleOutput: AnyObject {
    func chartsModuleDidFinish()
}

protocol ChartsViewInput: AnyObject {
    func showAlert(title: String, message: String)
    func setDataEntries(data: [(String, Double)])
}

protocol ChartsViewOutput: AnyObject {
    func viewDidLoad(with kind: SummaryKind)
}

protocol ChartsInteractorInput: AnyObject {
    func computeData(by data: Summary)
}

protocol ChartsInteractorOutput: AnyObject {
    func dataDidNotCompute()
    func dataDidCompute(data: [(String, Double)])
}

protocol ChartsRouterInput: AnyObject {
}
