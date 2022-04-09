//
//  Labels.swift
//  Agenda
//
//  Created by Егор Бадмаев on 09.04.2022.
//

enum Labels {
    static let yes = "yes".localized
    static let no = "no".localized
    static let goals = "goals".localized
    static let oopsError = "oopsError".localized
    
    enum Agenda {
        static let titleLabel = "titleLabel".localized
        static let currentLabel = "currentLabel".localized
        static let aimLabel = "aimLabel".localized
        static let notes = "notes".localized
        
        static let newGoal = "newGoal".localized
        static let saved = "saved".localized
        static let deleteGoalTitle = "deleteGoalTitle".localized
        static let deleteGoalDescription = "deleteGoalDescription".localized
    }
    
    enum History {
        static let title = "history".localized
        
        static let fetchErrorDescription = "fetchErrorDescription".localized
        static let currentMonthDeletion = "currentMonthDeletion".localized
        
        static let deleteMonthTitle = "deleteMonthTitle".localized
        static let deleteMonthDescription = "deleteMonthDescription".localized
    }
    
    enum Summary {
        static let title = "summary".localized
        static let fetchErrorDescription = "fetchErrorDescription".localized
        
        static let goals = "goalsConjugation".localized
        static let averageNumberOfCompletedGoals = "averageNumberOfCompletedGoals".localized
        static let completedGoals = "completedGoals".localized
        static let uncompletedGoals = "uncompletedGoals".localized
        static let allGoals = "allGoals".localized
    }
}
