//
//  GoalDetailsPresenterSpy.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 15.06.2022.
//

@testable import Agenda

class GoalDetailsPresenterSpy: GoalDetailsInteractorOutput {
    
    var goalData: GoalData!
    var goalDidRewriteBool = false
    var barButtonFlag: Bool!
    
    func goalDidLoad(goalData: GoalData) {
        self.goalData = goalData
    }
    
    func goalDidRewrite() {
        goalDidRewriteBool = true
    }
    
    func barButtonDidCheck(with flag: Bool) {
        barButtonFlag = flag
    }
}
