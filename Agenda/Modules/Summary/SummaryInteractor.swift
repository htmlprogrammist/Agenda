//
//  SummaryInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class SummaryInteractor {
    weak var output: SummaryInteractorOutput?
    
    public let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension SummaryInteractor: SummaryInteractorInput {
    func performFetch() {
        guard let months = coreDataManager.fetchMonths() else {
            output?.dataDidNotFetch()
            return
        }
        output?.dataDidFetch(months: months)
    }
}
