//
//  HistoryRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import UIKit

final class HistoryRouter: BaseRouter {
}

extension HistoryRouter: HistoryRouterInput {
    func showMonthDetailsModule(month: Month, moduleDependency: CoreDataManagerProtocol) {
        let context = MonthDetailsContext(moduleOutput: self, moduleDependency: moduleDependency, month: month)
        let container = MonthDetailsContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension HistoryRouter: MonthDetailsModuleOutput {
    func monthDetailsModuleDidFinish() {
        navigationController?.dismiss(animated: true)
    }
}
