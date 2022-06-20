//
//  SummaryUITests.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 18.06.2022.
//

import XCTest

class SummaryUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let device = XCUIDevice.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
}
