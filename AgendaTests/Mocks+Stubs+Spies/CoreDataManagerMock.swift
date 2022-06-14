//
//  CoreDataManagerMock.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 12.06.2022.
//

@testable import Agenda

class CoreDataManagerMock: CoreDataManagerProtocol {
    func fetchCurrentMonth() -> Month {
        return Month()
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
