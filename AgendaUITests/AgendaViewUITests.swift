//
//  AgendaViewTest.swift
//  AgendaUITests
//
//  Created by Егор Бадмаев on 11.06.2022.
//

import XCTest
@testable import Agenda

class AgendaViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let device = XCUIDevice.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
