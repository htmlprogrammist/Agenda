//
//  ChartsPresenterSpy.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 06.07.2022.
//

import XCTest
@testable import Agenda

final class ChartsPresenterSpy: ChartsInteractorOutput {
    
    var dataDidNotComputeBool = false
    var data: [(String, Double)]!
    
    func dataDidNotCompute() {
        dataDidNotComputeBool = true
    }
    
    func dataDidCompute(data: [(String, Double)]) {
        self.data = data
    }
}
