//
//  ChartsPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  
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
    func viewDidLoad(with kind: SummaryKind) {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            interactor.computeData(by: kind)
        }
    }
}

extension ChartsPresenter: ChartsInteractorOutput {
    func dataDidNotCompute() {
        DispatchQueue.main.async { [unowned self] in
            view?.showAlert(title: Labels.oopsError, message: Labels.Summary.computingDataError)
        }
    }
    
    func dataDidCompute(data: [Double]) {
        DispatchQueue.main.async { [unowned self] in
            view?.setDataEntries(data: data)
        }
    }
}
