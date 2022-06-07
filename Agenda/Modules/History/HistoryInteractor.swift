//
//  HistoryInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class HistoryInteractor {
    weak var output: HistoryInteractorOutput?
    
    public let coreDataManager: CoreDataManagerProtocol
    
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
        output?.dataDidFetch(months: months)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let month = months[indexPath.row]
        output?.showMonthDetailsModule(month: month, moduleDependency: coreDataManager)
    }
    
    func deleteMonth(at indexPath: IndexPath) {
        months.remove(at: indexPath.row)
        coreDataManager.deleteMonth(month: months[indexPath.row])
    }
}
