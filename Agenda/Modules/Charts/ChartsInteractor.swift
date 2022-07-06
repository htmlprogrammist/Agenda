//
//  ChartsInteractor.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  

import Foundation

final class ChartsInteractor {
    weak var output: ChartsInteractorOutput?
    
    /// Array of user's months history
    private let months: [Month]
    
    init(months: [Month]) {
        /// We need to reverse them to make the order be descending
        self.months = months.reversed()
    }
}

extension ChartsInteractor: ChartsInteractorInput {
    /// Method calls another method with computing data by provided `kind`
    /// - Parameter kind: kind of summary data
    func computeData(by data: Summary) {
        switch data.competion(months) {
        case .success(let result):
            output?.dataDidCompute(data: result)
        case .failure(_): // TODO: Depending on the provided error display correct message in alert
            output?.dataDidNotCompute()
        }
    }
}
