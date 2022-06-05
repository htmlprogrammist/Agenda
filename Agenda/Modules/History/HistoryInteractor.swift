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
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension HistoryInteractor: HistoryInteractorInput {
    func performFetch() {
        
        output?.dataDidFetch()
    }
}
