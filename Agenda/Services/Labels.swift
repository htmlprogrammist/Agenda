//
//  Labels.swift
//  Agenda
//
//  Created by Егор Бадмаев on 09.04.2022.
//

enum Labels {
    static let yes = "yes".localized
    static let no = "No"
    static let goals = "goals".localized
    static let oopsError = "Oops!"
    
    enum TabBarItemsNames {
        static let history = "history".localized
        static let summary = "summary".localized
    }
    
    enum Agenda {
        static let titleLabel = "Title"
        static let currentLabel = "Current"
        static let aimLabel = "Aim"
        static let notes = "Notes"
        
        static let newGoal = "New Goal"
        static let deleteGoalTitle = "Delete goal"
        static let deleteGoalDescription = "Are you sure you want to delete this goal? This action cannot be undone"
    }
    
    enum History {
        static let title = "History"
        
        static let fetchErrorDescription = "We've got unexpected error while loading your history. Please, restart the application"
        static let currentMonthDeletion = "You could not delete current month"
        
        static let deleteMonthTitle = "Delete month"
        static let deleteMonthDescription = "Are you sure you want to delete this month? This action cannot be undone"
    }
    
    enum Summary {
        static let title = "Summary"
        
        static let fetchErrorDescription = "We've got unexpected error while loading statistics. Please, restart the application"
    }
}
