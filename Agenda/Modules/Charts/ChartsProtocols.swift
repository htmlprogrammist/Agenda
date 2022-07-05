//
//  ChartsProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  
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
    func setDataEntries(data: [Double])
}

protocol ChartsViewOutput: AnyObject {
    func viewDidLoad(with kind: SummaryKind)
}

protocol ChartsInteractorInput: AnyObject {
    func computeData(by kind: SummaryKind)
}

protocol ChartsInteractorOutput: AnyObject {
    func dataDidNotCompute()
    func dataDidCompute(data: [Double])
}

protocol ChartsRouterInput: AnyObject {
}
