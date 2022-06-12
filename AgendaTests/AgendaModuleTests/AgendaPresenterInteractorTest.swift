//
//  AgendaPresenterInteractorTest.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 11.06.2022.
//

import XCTest
@testable import Agenda

class MockCoreDataManager: CoreDataManagerProtocol {
    func fetchCurrentMonth() -> Month? {
        return nil
    }
    func fetchMonths() -> [Month]? {
        return nil
    }
    func createGoal(data: GoalData, in month: Month) {}
    func rewriteGoal(with data: GoalData, in goal: Goal) {}
    func replaceGoal(_ goal: Goal, in month: Month, from: Int, to: Int) {}
    func deleteMonth(month: Month) {}
    func deleteGoal(goal: Goal) {}
    func saveContext() {}
}

class MockRouter: AgendaRouterInput {
    func showAddGoalModule(in month: Month, moduleDependency: CoreDataManagerProtocol) {}
    func showDetailsModule(by goal: Goal, moduleDependency: CoreDataManagerProtocol) {}
    func showOnboarding() {}
}

/**
 I am testing the `Presenter` and the `Interactor` together, since the `Presenter` is a proxy between the `View` and the `Interactor` without any branches
 */
class AgendaPresenterInteractorTest: XCTestCase {
    
    var presenter: AgendaPresenter!
    var interactor: AgendaInteractor!
    
    override func setUpWithError() throws {
        presenter = AgendaPresenter(router: MockRouter(), interactor: interactor)
        interactor = AgendaInteractor(coreDataManager: MockCoreDataManager())
        interactor.output = presenter
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        interactor = nil
    }
    
    func testFetchData() {
        presenter.fetchData()
    }
    
}
