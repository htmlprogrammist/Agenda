//
//  AgendaRouterTests.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 12.06.2022.
//

import XCTest
@testable import Agenda

class AgendaRouterTests: XCTestCase {
    
    var router: AgendaRouter!
    var viewController: UINavigationController!

    override func setUpWithError() throws {
        router = AgendaRouter()
        viewController = UINavigationController()
        
        router.navigationControllerProvider = { [weak viewController] in
            viewController
        }
    }

    override func tearDownWithError() throws {
        router = nil
        viewController = nil
    }
    
    /**
     Let's check that navigation controller is not equal to nil
     And that some view controller is presented
     */
    func testOpeningAddGoalModule() throws {
        let coreDataManager = CoreDataManagerStub(containerName: "Agenda")
        let month = coreDataManager.fetchCurrentMonth()
        router.showAddGoalModule(in: month, moduleDependency: coreDataManager)
        
        XCTAssertNotNil(router.navigationController, "Router's navigation controller should not be nil")
        XCTAssertNotIdentical(router.navigationController, router.navigationController?.presentedViewController)
    }
    
    func testOpeningGoalDetailsModule() throws {
        let coreDataManager = CoreDataManagerStub(containerName: "Agenda")
        let month = coreDataManager.fetchCurrentMonth()
        coreDataManager.createGoal(data: GoalData(title: "Sample goal", current: "\(75)", aim: "\(100)", notes: ""), in: month)
        
        if let goal = month.goals?.object(at: 0) as? Goal {
            router.showDetailsModule(by: goal, moduleDependency: coreDataManager)
        } else {
            XCTFail("Goal should not be nil")
        }
        
        XCTAssertNotNil(router.navigationController, "Router's navigation controller should not be nil")
        XCTAssertNotIdentical(router.navigationController, router.navigationController?.presentedViewController)
    }
    
    func testOpeningOnboardingModule() throws {
        router.showOnboarding()
        
        XCTAssertNotNil(router.navigationController, "Router's navigation controller should not be nil")
        XCTAssertNotIdentical(router.navigationController, router.navigationController?.presentedViewController)
    }
    
    /**
     Let's check that navigation controller is not equal to nil
     And that there is no view controller in presented
     */
    func testDismissingAddGoalModule() throws {
        let coreDataManager = CoreDataManagerStub(containerName: "Agenda")
        let month = coreDataManager.fetchCurrentMonth()
        
        router.showAddGoalModule(in: month, moduleDependency: coreDataManager)
        router.addGoalModuleDidFinish()
        
        XCTAssertNotNil(router.navigationController, "Router's navigation controller should not be nil")
        XCTAssertNil(router.navigationController?.presentedViewController, "There should be no presented view controller in router's navigation controller")
    }
    
    func testDismissingGoalDetailsModule() throws {
        let coreDataManager = CoreDataManagerStub(containerName: "Agenda")
        let month = coreDataManager.fetchCurrentMonth()
        coreDataManager.createGoal(data: GoalData(title: "Sample goal", current: "\(75)", aim: "\(100)", notes: ""), in: month)
        
        if let goal = month.goals?.object(at: 0) as? Goal {
            router.showDetailsModule(by: goal, moduleDependency: coreDataManager)
        } else {
            XCTFail("Goal should not be nil")
        }
        
        XCTAssertNotNil(router.navigationController, "Router's navigation controller should not be nil")
        XCTAssertNil(router.navigationController?.presentedViewController, "There should be no presented view controller in router's navigation controller")
    }
    
    func testDismissingOnboardingModule() throws {
        router.showOnboarding()
        router.onboardingModuleDidFinish()
        
        XCTAssertNotNil(router.navigationController, "Router's navigation controller should not be nil")
        XCTAssertNil(router.navigationController?.presentedViewController, "There should be no presented view controller in router's navigation controller")
    }
}
