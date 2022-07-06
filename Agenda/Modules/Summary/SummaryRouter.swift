//
//  SummaryRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import UIKit

final class SummaryRouter: BaseRouter {
}

extension SummaryRouter: SummaryRouterInput {
    func openChartsModuleWith(data: Summary, months: [Month]) {
        let context = ChartsContext(moduleOutput: self, data: data, months: months)
        let container = ChartsContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension SummaryRouter: ChartsModuleOutput {
    func chartsModuleDidFinish() {
        navigationController?.dismiss(animated: true)
    }
}
