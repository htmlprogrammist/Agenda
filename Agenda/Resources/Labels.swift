//
//  Labels.swift
//  Agenda
//
//  Created by Егор Бадмаев on 09.04.2022.
//

enum Labels {
    static let yes = "yes".localized
    static let cancel = "cancel".localized
    static let goals = "goals".localized
    static let oopsError = "oopsError".localized
    
    enum Onboarding {
        static let welcomeLabel = "welcomeLabel".localized
        static let continueButtonLabel = "continueButtonLabel".localized
        
        static let title1 = "title1".localized
        static let title2 = "title2".localized
        static let title3 = "title3".localized
        static let title4 = "title4".localized
        
        static let description1 = "description1".localized
        static let description2 = "description2".localized
        static let description3 = "description3".localized
        static let description4 = "description4".localized
    }
    
    enum Agenda {
        static let titleLabel = "titleLabel".localized
        static let currentLabel = "currentLabel".localized
        static let aimLabel = "aimLabel".localized
        static let notes = "notes".localized
        
        static let newGoal = "newGoal".localized
        static let details = "details".localized
        static let saved = "saved".localized
        static let deleteGoalTitle = "deleteGoalTitle".localized
        static let deleteGoalDescription = "deleteGoalDescription".localized
        static let unknownErrorDescription = "unknownErrorDescription".localized
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
        
        static let goalsDeclension = "goalsDeclension".localized
        static let percentOfSetGoals = "percentOfSetGoals".localized
        static let ofSetGoals = "ofSetGoals".localized
        static let completedGoals = "completedGoals".localized
        static let uncompletedGoals = "uncompletedGoals".localized
        static let allGoals = "allGoals".localized
    }
    
    enum Charts {
        static let computingDataError = "computingDataError".localized
        static let lessBetter = "lessBetter".localized
        static let moreBetter = "moreBetter".localized
        
        static let percentOfSetGoalsDescription = "percentOfSetGoalsDescription".localized
        static let completedGoalsDescription = "completedGoalsDescription".localized
        static let uncompletedGoalsDescription = "uncompletedGoalsDescription".localized
        static let allGoalsDescription = "allGoalsDescription".localized
    }
}
