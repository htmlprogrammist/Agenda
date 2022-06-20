//
//  OnboardingInteractorTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import XCTest
@testable import Agenda

class OnboardingPresenterSpy: OnboardingInteractorOutput {
    var hasOnboardedDidSetBool = false
    
    func hasOnboardedDidSet() {
        hasOnboardedDidSetBool = true
    }
}

class OnboardingInteractorTests: XCTestCase {
    
    var interactor: OnboardingInteractor!
    var presenter: OnboardingPresenterSpy!

    override func setUpWithError() throws {
        interactor = OnboardingInteractor()
        presenter = OnboardingPresenterSpy()
        interactor.output = presenter
    }

    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
    }

    func testSettingHasOnboarded() {
        let settings = UserSettings()
        
        interactor.setHasOnboarded()
        
        XCTAssertTrue(presenter.hasOnboardedDidSetBool)
        guard let hasOnboarded = settings.hasOnboarded else {
            XCTFail("Has onboarded in UserDefaults should not be nil")
            return
        }
        XCTAssertTrue(hasOnboarded)
    }
}
