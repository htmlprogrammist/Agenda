//
//  AddGoalProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import Foundation

protocol AddGoalModuleInput {
    var moduleOutput: AddGoalModuleOutput? { get }
}

protocol AddGoalModuleOutput: AnyObject {
    func addGoalModuleDidFinish()
}

protocol AddGoalViewInput: AnyObject {
}

protocol AddGoalViewOutput: AnyObject {
    func doneButtonTapped(data: GoalData)
    
    func closeThisModule()
}

protocol AddGoalInteractorInput: AnyObject {
    func createGoal(goalData: GoalData)
}

protocol AddGoalInteractorOutput: AnyObject {
    func goalDidCreate()
}

protocol AddGoalRouterInput: AnyObject {
}
