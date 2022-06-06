//
//  MonthViewModel.swift
//  Agenda
//
//  Created by Егор Бадмаев on 05.06.2022.
//

struct MonthViewModel {
    let date: String
    let goalsCounter: String
    
    init(month: Month) {
        self.date = month.date.formatTo("MMMMy")
        
        var completedGoalsCounter = 0
        var monthGoals = [Goal]()
        
        if let goals = month.goals?.array as? [Goal] {
            monthGoals = goals
            for goal in goals {
                if goal.current >= goal.aim {
                    completedGoalsCounter += 1
                }
            }
        }
        
        self.goalsCounter = "\(Labels.goals): \(completedGoalsCounter)/\(monthGoals.count)"
    }
}
