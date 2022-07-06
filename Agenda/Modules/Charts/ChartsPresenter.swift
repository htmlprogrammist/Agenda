//
//  ChartsPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//

import Foundation

final class ChartsPresenter {
    weak var view: ChartsViewInput?
    weak var moduleOutput: ChartsModuleOutput?
    
    private let router: ChartsRouterInput
    private let interactor: ChartsInteractorInput
    
    init(router: ChartsRouterInput, interactor: ChartsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ChartsPresenter: ChartsModuleInput {
}

extension ChartsPresenter: ChartsViewOutput {
    /// This method is being called when `viewDidLoad` method in `view` is being called
    /// - Parameter kind: describes what kind of data you need to show charts with
    func viewDidLoad(with kind: SummaryKind) {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            interactor.computeData(by: kind)
        }
    }
}

extension ChartsPresenter: ChartsInteractorOutput {
    /// This method handles errors
    func dataDidNotCompute() {
        DispatchQueue.main.async { [unowned self] in
            view?.showAlert(title: Labels.oopsError, message: Labels.Charts.computingDataError)
        }
    }
    
    /// This method provides data from Interactor to View
    /// - Parameter data: array of month's name and value by month
    func dataDidCompute(data: [(String, Double)]) {
        DispatchQueue.main.async { [unowned self] in
            view?.setDataEntries(data: data)
        }
    }
}
