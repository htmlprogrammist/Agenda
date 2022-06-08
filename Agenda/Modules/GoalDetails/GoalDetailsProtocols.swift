//
//  GoalDetailsProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import Foundation

protocol GoalDetailsModuleInput {
    var moduleOutput: GoalDetailsModuleOutput? { get }
}

protocol GoalDetailsModuleOutput: AnyObject {
    func goalDetailsModuleDidFinish()
}

protocol GoalDetailsViewInput: AnyObject {
    func setViewModel(goalData: GoalData)
    func updateBarButton(with flag: Bool)
    func presentSuccess()
}

protocol GoalDetailsViewOutput: AnyObject {
    func viewDidLoad()
    
    func saveButtonTapped(data: GoalData)
    func checkBarButtonEnabled(goalData: GoalData)
}

protocol GoalDetailsInteractorInput: AnyObject {
    func provideData()
    func rewriteGoal(with data: GoalData)
    func checkBarButtonEnabled(goalData: GoalData)
}

protocol GoalDetailsInteractorOutput: AnyObject {
    func goalDidLoad(goalData: GoalData)
    func goalDidRewrite()
    func barButtonDidCheck(with flag: Bool)
}

protocol GoalDetailsRouterInput: AnyObject {
}
