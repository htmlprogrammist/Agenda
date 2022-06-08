//
//  HistoryInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class HistoryInteractor {
    weak var output: HistoryInteractorOutput?
    
    private let coreDataManager: CoreDataManagerProtocol
    private var months = [Month]()
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension HistoryInteractor: HistoryInteractorInput {
    func performFetch() {
        guard let months = coreDataManager.fetchMonths() else {
            output?.dataDidNotFetch()
            return
        }
        self.months = months
        output?.dataDidFetch(viewModels: makeViewModels(months))
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let month = months[indexPath.row]
        output?.showMonthDetailsModule(month: month, moduleDependency: coreDataManager)
    }
    
    func deleteMonthAt(_ indexPath: IndexPath) {
        coreDataManager.deleteMonth(month: months[indexPath.row])
        months.remove(at: indexPath.row)
    }
}

// MARK: - Helper methods
private extension HistoryInteractor {
    func makeViewModels(_ months: [Month]) -> [MonthViewModel] {
        return months.map { MonthViewModel(month: $0) }
    }
}
